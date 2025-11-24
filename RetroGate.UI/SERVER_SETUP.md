# Configuração do Servidor gRPC

Para que o RetroGate.UI funcione corretamente, você precisa ter o servidor gRPC rodando.

## Iniciar o Servidor RetroGate.Grpc

### Opção 1: Usando dotnet run

```powershell
cd d:\projects\retrogate\retrogate_app\RetroGate.Grpc
dotnet run
```

### Opção 2: Usando watch mode (recarrega automaticamente ao fazer mudanças)

```powershell
cd d:\projects\retrogate\retrogate_app
dotnet watch run --project RetroGate.Grpc/RetroGate.Grpc.csproj
```

### Opção 3: Usando as tasks do VS Code

Você pode usar a task `watch-grpc` que já está configurada no workspace.

## Verificar se o Servidor Está Rodando

O servidor gRPC geralmente roda em:
- **HTTP**: `http://localhost:5000`
- **HTTPS**: `https://localhost:5001`

Verifique o arquivo `RetroGate.Grpc/Properties/launchSettings.json` para confirmar as portas.

## Configurar o Cliente Flutter

No arquivo `lib/modules/game/game_module.dart`, configure o host e porta:

```dart
i.addLazySingleton<GameGrpcDataSource>(
  () => GameGrpcDataSource(
    host: 'localhost',
    port: 5000,  // Use a porta HTTP do servidor
  ),
);
```

## Testar a Conexão

### Usando grpcurl (se instalado)

```bash
grpcurl -plaintext localhost:5000 list
```

### Ou verifique os logs do servidor

Quando você executar o Flutter app, deve ver logs de conexão no console do servidor .NET.

## Problemas Comuns

### 1. Servidor não inicia
- Verifique se a porta 5000 não está em uso
- Veja os logs de erro no console

### 2. Cliente não conecta
- Confirme que o servidor está rodando
- Verifique se as portas correspondem
- Use `ChannelCredentials.insecure()` para HTTP (desenvolvimento)
- Use `ChannelCredentials.secure()` para HTTPS (produção)

### 3. Erro de certificado SSL
Em desenvolvimento, use HTTP sem TLS:

```dart
GameGrpcDataSource(
  host: 'localhost',
  port: 5000,
  // Usa HTTP sem TLS
)
```
