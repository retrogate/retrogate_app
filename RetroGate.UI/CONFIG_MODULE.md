# Módulo de Configurações - RetroGate

## 📋 Estrutura Criada

### Domain Layer
```
lib/modules/config/domain/
├── models/
│   └── config.dart                    # Modelo de configuração com steamPath, steamUserId, steamGridDbApiKey
├── repository/
│   └── i_config_repository.dart       # Interface do repositório
└── usecases/
    ├── get_config_usecase.dart        # Caso de uso para obter configurações
    └── set_config_usecase.dart        # Caso de uso para salvar configurações
```

### Infrastructure Layer
```
lib/modules/config/infra/
├── datasources/
│   └── config_grpc_datasource.dart    # Cliente gRPC para ConfigService
└── repository/
    └── config_repository.dart         # Implementação do repositório
```

### Presentation Layer
```
lib/modules/config/presentation/
├── bloc/
│   ├── config_bloc.dart               # BLoC para gerenciar estado
│   ├── config_event.dart              # Eventos (LoadConfig, SaveConfig, etc)
│   └── config_state.dart              # Estados (Loading, Loaded, Saving, Saved, Error)
└── config_page.dart                   # Tela de configurações com formulário
```

### Module
```
lib/modules/config/
└── config_module.dart                 # Módulo Modular com DI e rotas
```

## 🎨 UI da Tela de Configurações

### Design Steam-like
- **Cores**: Mesmo padrão do Steam Big Picture
  - Background: `#1B2838`
  - AppBar: `#171A21`
  - Destaque: `#66C0F4`
  - Bordas: `#2A475E`

### Campos do Formulário
1. **Steam Path**
   - Label: "Steam Path"
   - Hint: "C:\Program Files (x86)\Steam"
   - Ícone: Pasta
   - Validação: Campo obrigatório

2. **Steam User ID**
   - Label: "Steam User ID"
   - Hint: "1234567890"
   - Ícone: Person
   - Validação: Campo obrigatório

3. **SteamGridDB API Key**
   - Label: "SteamGridDB API Key"
   - Hint: "Get your key from steamgriddb.com"
   - Ícone: Key
   - Tipo: Obscured (senha)
   - Validação: Campo obrigatório

### Features
- ✅ Validação de formulário
- ✅ Loading states (carregando/salvando)
- ✅ Feedback visual (SnackBar)
- ✅ Auto-preenchimento com dados do servidor
- ✅ Botão de voltar para tela de jogos

## 🧭 Navegação

### Menu Drawer
Adicionado drawer na tela de jogos com:
- **Header**: Logo RetroGate
- **Games Library**: Navega para `/games/` (selected)
- **Settings**: Navega para `/config/`
- **Footer**: Version info

### Rotas Configuradas
```dart
AppModule:
  /games/     → GameModule
  /config/    → ConfigModule
  /           → Redirect to /games/
```

## 🔧 Estados do BLoC

### Events
- `LoadConfig`: Carrega configurações do servidor
- `UpdateSteamPath`: Atualiza steam path localmente
- `UpdateSteamUserId`: Atualiza user ID localmente
- `UpdateSteamGridDbApiKey`: Atualiza API key localmente
- `SaveConfig`: Persiste configurações no servidor

### States
- `ConfigInitial`: Estado inicial
- `ConfigLoading`: Carregando configurações
- `ConfigLoaded`: Configurações carregadas
- `ConfigSaving`: Salvando configurações
- `ConfigSaved`: Configurações salvas com sucesso
- `ConfigError`: Erro ao carregar/salvar

## 🚀 Como Usar

### 1. Navegar para Configurações
- Abrir drawer (menu hambúrguer)
- Clicar em "Settings"

### 2. Preencher Formulário
- Inserir caminho do Steam
- Inserir Steam User ID
- Inserir SteamGridDB API Key

### 3. Salvar
- Clicar em "Save Configuration"
- Aguardar confirmação
- Voltar para biblioteca de jogos

## 🔌 Integração gRPC

### Proto Files
```protobuf
// config_model.proto
message ConfigModel {
    string steam_path = 1;
    string steam_user_id = 2;
    string steam_grid_db_api_key = 3;
}

// config_service.proto
service ConfigService {
    rpc GetConfig(google.protobuf.Empty) returns (ConfigModel);
    rpc SetConfig(ConfigModel) returns (google.protobuf.Empty);
}
```

### Código Gerado
```
lib/generated/config/proto/v1/
├── config_model.pb.dart        # Model gerado
└── config_service.pbgrpc.dart  # Service client gerado
```

## ✅ Checklist de Implementação

- [x] Gerar código Dart dos protos
- [x] Domain layer (models, repository, usecases)
- [x] Infrastructure layer (datasource, repository impl)
- [x] Presentation layer (BLoC, events, states)
- [x] UI (config_page.dart com formulário)
- [x] Module (DI e rotas)
- [x] Navigation drawer
- [x] Atualizar app_module.dart
- [ ] Testar navegação completa
- [ ] Testar persistência de dados
- [ ] Validar integração gRPC com backend

## 🎯 Próximos Passos

1. **Testar fluxo completo**:
   - Iniciar servidor gRPC (.NET)
   - Executar app Flutter
   - Navegar entre telas
   - Salvar configurações
   - Verificar persistência

2. **Melhorias futuras**:
   - File picker para Steam path
   - Validação de formato do User ID
   - Link para obter API key da SteamGridDB
   - Cache local de configurações
   - Dark/Light theme toggle
