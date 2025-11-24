# RetroGate.UI - Guia de Uso

## Estrutura do Projeto

O projeto RetroGate.UI foi criado seguindo os princípios da Clean Architecture:

```
RetroGate.UI/
├── lib/
│   ├── app_module.dart                    # Módulo principal da aplicação
│   ├── main.dart                          # Ponto de entrada
│   ├── generated/                         # Código gerado pelos arquivos .proto
│   │   ├── game/proto/v1/                 # Modelos e serviços gRPC de jogos
│   │   └── google/protobuf/               # Tipos bem conhecidos do protobuf
│   └── modules/
│       └── game/
│           ├── game_module.dart           # Módulo de injeção de dependências
│           ├── domain/                    # Camada de domínio (regras de negócio)
│           │   ├── models/
│           │   │   ├── game.dart          # Modelo de domínio Game
│           │   │   └── game_images.dart   # Modelo de domínio GameImages
│           │   ├── repositories/
│           │   │   └── game_repository.dart  # Interface do repositório
│           │   └── usecases/
│           │       └── get_all_games_usecase.dart  # Caso de uso para listar jogos
│           ├── infra/                     # Camada de infraestrutura
│           │   ├── datasources/
│           │   │   └── game_grpc_datasource.dart  # Cliente gRPC
│           │   └── repositories/
│           │       └── game_repository_impl.dart  # Implementação do repositório
│           └── presentation/              # Camada de apresentação
│               └── games_list_page.dart   # Tela de listagem de jogos
└── protos/                                # Arquivos .proto copiados do servidor
    ├── game/proto/v1/
    │   ├── game_model.proto
    │   ├── game_images_model.proto
    │   └── game_service.proto
    └── google/protobuf/
        └── empty.proto
```

## Camadas da Arquitetura

### 1. Domain (Domínio)
**Responsabilidade**: Contém a lógica de negócio pura, independente de frameworks.

- **Models**: Entidades de negócio (`Game`, `GameImages`)
- **Repositories**: Interfaces que definem contratos de acesso a dados
- **UseCases**: Casos de uso que implementam as regras de negócio

### 2. Infrastructure (Infraestrutura)
**Responsabilidade**: Implementa os detalhes técnicos de acesso a dados externos.

- **DataSources**: Comunicação com APIs externas (gRPC, REST, etc.)
- **Repositories**: Implementação concreta dos repositórios definidos no domínio

### 3. Presentation (Apresentação)
**Responsabilidade**: Interface do usuário e interação com o usuário.

- **Pages**: Telas da aplicação
- **Widgets**: Componentes reutilizáveis de UI

## Injeção de Dependências

O projeto usa **flutter_modular** para injeção de dependências:

### GameModule (`lib/modules/game/game_module.dart`)

```dart
class GameModule extends Module {
  @override
  void binds(Injector i) {
    // DataSource - Singleton lazy (criado apenas quando necessário)
    i.addLazySingleton<GameGrpcDataSource>(
      () => GameGrpcDataSource(
        host: 'localhost',  // Configure o host do servidor
        port: 5000,         // Configure a porta do servidor
      ),
    );

    // Repository
    i.addLazySingleton<IGameRepository>(
      () => GameRepository(i.get<GameGrpcDataSource>()),
    );

    // UseCases
    i.addLazySingleton<GetAllGamesUseCase>(
      () => GetAllGamesUseCase(i.get<IGameRepository>()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const GamesListPage());
  }
}
```

### Como usar as dependências

```dart
// Obter uma dependência em qualquer lugar do código
final useCase = Modular.get<GetAllGamesUseCase>();

// Usar o caso de uso
final result = await useCase();
result.fold(
  (error) => print('Erro: $error'),
  (games) => print('Jogos: $games'),
);
```

## Comunicação gRPC

### Cliente gRPC (`game_grpc_datasource.dart`)

O cliente gRPC se conecta ao servidor RetroGate:

```dart
class GameGrpcDataSource {
  final ClientChannel channel;
  late final GameServiceClient _client;

  GameGrpcDataSource({
    required String host,
    required int port,
  }) : channel = ClientChannel(
          host,
          port: port,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ),
        ) {
    _client = GameServiceClient(channel);
  }

  Future<List<GameModel>> getAll() async {
    final response = await _client.getAll(Empty());
    return response.games;
  }
  
  // Outros métodos...
}
```

### Configuração do Servidor

Para conectar a um servidor diferente, edite `game_module.dart`:

```dart
i.addLazySingleton<GameGrpcDataSource>(
  () => GameGrpcDataSource(
    host: '192.168.1.100',  // IP do servidor
    port: 5000,             // Porta do servidor
  ),
);
```

## Tratamento de Erros

O projeto usa **dartz** para tratamento funcional de erros:

```dart
Future<Either<Exception, List<Game>>> getAll() async {
  try {
    final protoGames = await dataSource.getAll();
    final games = protoGames.map((proto) => Game.fromProto(proto)).toList();
    return Right(games);  // Sucesso
  } catch (e) {
    return Left(Exception(e.toString()));  // Erro
  }
}
```

### Usando Either na UI

```dart
final result = await _getAllGamesUseCase();

result.fold(
  (error) {
    // Lado esquerdo = erro
    setState(() {
      _errorMessage = error.toString();
    });
  },
  (games) {
    // Lado direito = sucesso
    setState(() {
      _games = games;
    });
  },
);
```

## Como Executar

### 1. Instalar dependências

```bash
cd RetroGate.UI
flutter pub get
```

### 2. Verificar o projeto

```bash
flutter analyze
```

### 3. Executar no dispositivo

```bash
flutter run
```

### 4. Para dispositivos específicos

```bash
# Listar dispositivos disponíveis
flutter devices

# Executar em um dispositivo específico
flutter run -d <device_id>

# Executar no navegador
flutter run -d chrome
```

## Regenerar Código gRPC

Se você modificar os arquivos `.proto`, regenere o código Dart:

```bash
# Ativar o plugin protoc para Dart
dart pub global activate protoc_plugin 21.1.2

# Regenerar os arquivos
protoc --dart_out=grpc:lib/generated --proto_path=protos protos/google/protobuf/empty.proto protos/game/proto/v1/game_model.proto protos/game/proto/v1/game_images_model.proto protos/game/proto/v1/game_service.proto
```

## Próximos Passos

1. **Adicionar novas funcionalidades**:
   - Tela de detalhes do jogo
   - Instalação de jogos
   - Gerenciamento de atalhos
   - Configurações da aplicação

2. **Melhorias**:
   - Cache local de jogos
   - Modo offline
   - Busca e filtros avançados
   - Imagens de preview dos jogos

3. **Integrar outros serviços gRPC**:
   - ConfigService
   - ShortcutService
   - InstallerService
