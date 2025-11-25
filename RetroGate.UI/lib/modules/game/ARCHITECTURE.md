# Game Module - Architecture

## Repository Separation

Following the server architecture, the game module is now separated into two distinct repositories:

### 1. Available Games Repository (`IAvailableGamesRepository`)
**Purpose:** Manages the catalog of games available for installation/download.

**Operations:**
- `create(source, game)` - Add new game to catalog
- `getById(source, id)` - Get game details by ID
- `getAll(source)` - List all available games
- `findByName(source, name)` - Search games by name
- `getImages(gameName)` - Fetch game images from SteamGridDB
- `update(source, game)` - Update game information
- `delete(source, id)` - Remove game from catalog

**Current Implementation:**
- Location: `infra/repositories/available_games_repository_impl.dart`
- Used by: Games list page (current main screen)
- UseCases: `GetAllGamesUseCase`, `CreateGameUseCase`, `GetGameImagesUseCase`

### 2. Installed Games Repository (`IInstalledGamesRepository`)
**Purpose:** Manages locally installed games.

**Operations:**
- `getById(source, id)` - Get installed game details
- `getAll(source)` - List all installed games
- `findByName(source, name)` - Search installed games
- `findInstalledGames()` - Get games installed on the system
- `update(source, game)` - Update installed game settings
- `delete(source, id)` - Uninstall/remove game

**Current Implementation:**
- Location: `infra/repositories/installed_games_repository_impl.dart`
- Status: Ready for future implementation
- UseCases: `GetInstalledGamesUseCase` (ready to use)

## Directory Structure

```
lib/modules/game/
├── domain/
│   ├── models/
│   │   ├── game.dart
│   │   ├── game_images.dart
│   │   └── game_source.dart
│   ├── repositories/
│   │   ├── available_games_repository.dart
│   │   ├── installed_games_repository.dart
│   │   └── game_repository.dart (legacy - to be removed)
│   └── usecases/
│       ├── create_game_usecase.dart (uses AvailableGames)
│       ├── get_all_games_usecase.dart (uses AvailableGames)
│       ├── get_game_images_usecase.dart (uses AvailableGames)
│       └── get_installed_games_usecase.dart (uses InstalledGames)
├── infra/
│   ├── datasources/
│   │   └── game_grpc_datasource.dart
│   └── repositories/
│       ├── available_games_repository_impl.dart
│       ├── installed_games_repository_impl.dart
│       └── game_repository_impl.dart (legacy - to be removed)
├── presentation/
│   ├── bloc/
│   ├── games_list_page.dart (Available Games)
│   └── add_game_page.dart
└── game_module.dart

```

## Dependency Injection

The `game_module.dart` registers both repositories:

```dart
// Available Games Repository
i.addLazySingleton<IAvailableGamesRepository>(
  () => AvailableGamesRepositoryImpl(i.get<GameGrpcDataSource>()),
);

// Installed Games Repository
i.addLazySingleton<IInstalledGamesRepository>(
  () => InstalledGamesRepositoryImpl(i.get<GameGrpcDataSource>()),
);
```

## Future Implementation

### Installed Games Screen
When implementing the installed games screen, follow this pattern:

1. Create new BLoC for installed games
2. Inject `GetInstalledGamesUseCase`
3. Create UI page similar to `games_list_page.dart`
4. Add route in `game_module.dart`

Example BLoC:
```dart
class InstalledGamesBloc extends Bloc<InstalledGamesEvent, InstalledGamesState> {
  final GetInstalledGamesUseCase getInstalledGamesUseCase;
  
  InstalledGamesBloc({required this.getInstalledGamesUseCase}) 
      : super(InstalledGamesInitial());
      
  // ... implementation
}
```

## Migration Notes

- ✅ All current screens use `IAvailableGamesRepository`
- ✅ Legacy `IGameRepository` can be safely removed after testing
- ✅ Legacy `game_repository_impl.dart` can be removed after testing
- ⏳ Installed games functionality ready for implementation
