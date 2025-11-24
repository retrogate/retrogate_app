# Installer Module

Module responsible for managing game installations, including download, extraction, and shortcut creation.

## Architecture

Follows Clean Architecture:
- **Domain**: Models, repositories (interfaces), and use cases
- **Infra**: Implementations (gRPC datasource and repository)

## Structure

```
installer/
├── domain/
│   ├── models/
│   │   └── installer_progress.dart       # Installation progress model
│   ├── repositories/
│   │   └── installer_repository.dart     # Repository interface
│   └── usecases/
│       ├── install_game_usecase.dart     # Install game
│       ├── cancel_installation_usecase.dart  # Cancel installation
│       ├── delete_game_usecase.dart      # Delete game files
│       └── subscribe_to_progress_usecase.dart # Progress stream
└── infra/
    ├── datasources/
    │   └── installer_grpc_datasource.dart  # gRPC client
    └── repositories/
        └── installer_repository_impl.dart   # Repository implementation
```

## Models

### InstallerProgress

Represents the current state of an installation:

```dart
class InstallerProgress {
  final String gameId;
  final InstallerProgressState state;
  final int percentage;           // 0-100
  final int speedInKbPerSec;      // Download speed in KB/s
}
```

### InstallerProgressState

Possible states:
- `idle` - Idle
- `downloading` - Downloading files
- `extracting` - Extracting files
- `creatingShortcut` - Creating shortcut
- `paused` - Paused
- `completed` - Completed
- `failed` - Failed

## Use Cases

### 1. Install a Game

```dart
final installUseCase = InstallGameUseCase(repository);

final installPath = await installUseCase.call(
  gameId: 'game-123',
  replace: false,        // Reinstall if already installed?
  restartSteam: false,   // Restart Steam after creating shortcut?
);

print('Game installed at: $installPath');
```

### 2. Monitor Installation Progress

```dart
final subscribeUseCase = SubscribeToProgressUseCase(repository);

subscribeUseCase.call().listen((progress) {
  print('Game: ${progress.gameId}');
  print('State: ${progress.stateLabel}');
  print('Progress: ${progress.percentage}%');
  print('Speed: ${progress.speedFormatted}');
  
  if (progress.isCompleted) {
    print('Installation completed!');
  } else if (progress.isFailed) {
    print('Installation failed!');
  }
});
```

### 3. Cancel Installation

```dart
final cancelUseCase = CancelInstallationUseCase(repository);

await cancelUseCase.call('game-123');
```

### 4. Delete Game

```dart
final deleteUseCase = DeleteGameUseCase(repository);

await deleteUseCase.call([
  'C:\\Games\\MyGame',
  'C:\\Users\\User\\AppData\\Roaming\\MyGame',
]);
```

## Complete Example

```dart
// 1. Create datasource
final dataSource = InstallerGrpcDataSource(
  host: 'localhost',
  port: 5000,
);

// 2. Create repository
final repository = InstallerRepositoryImpl(dataSource);

// 3. Create use cases
final installUseCase = InstallGameUseCase(repository);
final subscribeUseCase = SubscribeToProgressUseCase(repository);
final cancelUseCase = CancelInstallationUseCase(repository);

// 4. Subscribe to progress
final subscription = subscribeUseCase.call().listen((progress) {
  print('${progress.gameId}: ${progress.percentage}% - ${progress.stateLabel}');
});

// 5. Start installation
try {
  final path = await installUseCase.call(gameId: 'sonic-mania');
  print('Installed at: $path');
} catch (e) {
  print('Error: $e');
}

// 6. Cleanup
subscription.cancel();
dataSource.dispose();
```

## Useful Properties

### InstallerProgress

- `stateLabel`: User-friendly string of current state
- `speedFormatted`: Formatted speed (KB/s or MB/s)
- `isInProgress`: true if downloading/extracting/creating shortcut
- `isCompleted`: true if completed
- `isFailed`: true if failed
- `isPaused`: true if paused

## Event Stream

The `subscribeToProgress()` method returns a `Stream<InstallerProgress>` that emits events whenever:
- Download starts
- Progress is updated
- State changes (download → extraction → shortcut)
- Installation completes or fails

**Important**: The stream is continuous and emits events for **all games** being installed. Filter by `gameId` if needed:

```dart
subscribeUseCase.call()
  .where((progress) => progress.gameId == 'my-game-id')
  .listen((progress) {
    // Process only events for the specific game
  });
```
