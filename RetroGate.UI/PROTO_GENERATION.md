# Protocol Buffers Code Generation

Este projeto usa Protocol Buffers (proto3) para comunicação gRPC entre o cliente Flutter e o servidor C#.

## Estrutura

- **Definições**: `../RetroGate.Protos/` (fonte única de verdade)
- **Código Gerado**: `lib/generated/` (gerado automaticamente)
- **Dependências**: `protos/google/protobuf/` (arquivos comuns do protobuf)

## Makefile

O projeto inclui um Makefile para facilitar a geração de código Dart a partir dos arquivos `.proto`.

### Comandos Disponíveis

```bash
# Ver ajuda
make help

# Gerar todos os módulos
make gen

# Gerar módulo específico
make gen-game        # Módulo de jogos
make gen-config      # Módulo de configuração
make gen-installer   # Módulo de instalação
make gen-shortcut    # Módulo de atalhos

# Limpar arquivos gerados
make clean
```

### Uso Típico

Após modificar qualquer arquivo `.proto` em `RetroGate.Protos`:

```bash
cd RetroGate.UI
make gen
```

Ou para regenerar apenas um módulo específico:

```bash
make gen-installer
```

## Módulos

### Game
- `game_model.proto` - Modelo de dados de jogos
- `game_images_model.proto` - Modelo de imagens do jogo
- `game_service.proto` - Serviço gRPC de jogos

### Config
- `config_model.proto` - Modelo de configuração
- `config_service.proto` - Serviço gRPC de configuração

### Installer
- `installer_event_model.proto` - Eventos de progresso de instalação
- `installer_service.proto` - Serviço gRPC de instalação

### Shortcut
- `shortcut_model.proto` - Modelo de atalhos
- `shortcut_service.proto` - Serviço gRPC de atalhos

## Requisitos

- `protoc` - Protocol Buffers compiler
- `protoc-gen-dart` - Plugin Dart para protoc

### Instalação

```bash
# Instalar plugin Dart para protoc
dart pub global activate protoc_plugin
```

## Troubleshooting

### Erro: "protoc: command not found"

Instale o Protocol Buffers compiler:
- Windows: `choco install protoc`
- macOS: `brew install protobuf`
- Linux: `apt-get install protobuf-compiler`

### Erro: "protoc-gen-dart: program not found"

Certifique-se de que o plugin Dart está instalado e no PATH:

```bash
dart pub global activate protoc_plugin
# Adicione ao PATH: %USERPROFILE%\AppData\Local\Pub\Cache\bin
```

## Estrutura de Código Gerado

```
lib/generated/
├── game/
│   └── proto/v1/
│       ├── game_model.pb.dart
│       ├── game_model.pbenum.dart
│       ├── game_model.pbjson.dart
│       ├── game_images_model.pb.dart
│       ├── game_service.pb.dart
│       └── game_service.pbgrpc.dart
├── config/
├── installer/
├── shortcut/
└── google/
    └── protobuf/
        └── empty.pb.dart
```

## Notas Importantes

1. **Não edite arquivos gerados**: Todos os arquivos em `lib/generated/` são gerados automaticamente
2. **Fonte única**: As definições `.proto` estão em `RetroGate.Protos`
3. **Versioning**: Arquivos gerados não devem ser commitados (já estão no .gitignore)
4. **Sincronização**: Execute `make gen` após cada pull que modifique os protos
