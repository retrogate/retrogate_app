# RetroGate.UI

Flutter application for RetroGate - A game management system with gRPC integration and gamepad support.

## 🎮 Features

- **Game Library**: Browse your game collection with a Steam Big Picture inspired interface
- **Gamepad Navigation**: Full controller support (Xbox, PlayStation, etc.)
- **BLoC State Management**: Reactive and testable state management
- **gRPC Integration**: Real-time communication with RetroGate server
- **Responsive Design**: Adaptive grid layout (1-6 columns based on screen size)
- **Clean Architecture**: Maintainable and scalable codebase

## 🎨 UI Design

The interface is inspired by **Steam Big Picture Mode**, featuring:
- Vertical poster images (3:4 aspect ratio)
- Steam color palette (#66C0F4 blue, #1B2838 background)
- Smooth hover effects with AnimatedScale
- Glowing selection indicators
- Play button overlay on hover/selection

## 🕹️ Gamepad Support

Navigate your game library using a gamepad:
- **D-Pad / Left Analog**: Navigate between games
- **A Button / Cross**: Select game
- **Keyboard Fallback**: Arrow keys + Enter/Space

See [GAMEPAD_SUPPORT.md](GAMEPAD_SUPPORT.md) for detailed gamepad documentation.

## 🏗️ Architecture

This project follows **Clean Architecture** principles with the following layers:

### Domain Layer
- **Models**: Pure Dart classes representing business entities
  - `Game`: Represents a game with all its properties
  - `GameImages`: Represents game images (hero, poster, logo)
- **Repositories**: Abstract interfaces defining data operations
  - `IGameRepository`: Interface for game data operations
- **Use Cases**: Business logic implementation
  - `GetAllGamesUseCase`: Retrieves all available games

### Infrastructure Layer
- **DataSources**: External data source implementations
  - `GameGrpcDataSource`: gRPC client for communicating with RetroGate server
- **Repositories**: Concrete implementations of repository interfaces
  - `GameRepository`: Implementation of IGameRepository using gRPC

### Presentation Layer
- **Pages**: UI screens
  - `GamesListPage`: Displays list of available games with Steam-like design
- **BLoC**: State management using BLoC pattern
  - `GamesBloc`: Manages game list states and events
- **Widgets**: Reusable UI components
  - `GamepadNavigationWrapper`: Gamepad/joystick navigation support

## 📦 Dependencies

- **flutter_modular** ^6.3.4: Dependency injection and route management
- **flutter_bloc** ^8.1.6: State management with BLoC pattern
- **equatable** ^2.0.5: Value equality for BLoC states/events
- **grpc** ^4.0.1: gRPC client for Dart
- **protobuf** ^3.1.0: Protocol Buffers support
- **dartz** ^0.10.1: Functional programming (Either type for error handling)
- **gamepads** ^0.1.9: Gamepad/joystick input handling

## 📁 Project Structure

```
lib/
├── app_module.dart                 # Main application module
├── main.dart                       # Application entry point
├── generated/                      # Auto-generated gRPC code
│   └── game/proto/v1/
└── modules/
    └── game/
        ├── game_module.dart        # Game feature module
        ├── domain/
        │   ├── models/
        │   │   ├── game.dart
        │   │   └── game_images.dart
        │   ├── repositories/
        │   │   └── game_repository.dart
        │   └── usecases/
        │       └── get_all_games_usecase.dart
        ├── infra/
        │   ├── datasources/
        │   │   └── game_grpc_datasource.dart
        │   └── repositories/
        │       └── game_repository_impl.dart
        └── presentation/
            ├── bloc/
            │   ├── bloc.dart
            │   ├── games_bloc.dart
            │   ├── games_event.dart
            │   └── games_state.dart
            ├── widgets/
            │   └── gamepad_navigation_wrapper.dart
            └── games_list_page.dart

protos/
└── game/proto/v1/
    ├── game_model.proto
    ├── game_images_model.proto
    └── game_service.proto
```

## 🚀 Setup

### Prerequisites
- Flutter SDK (3.9.0 or higher)
- Protocol Buffers Compiler (protoc)
- Dart protoc plugin
- RetroGate gRPC server running

### Installation

1. Install dependencies:
```bash
flutter pub get
```

2. Generate gRPC code from proto files:
```bash
dart pub global activate protoc_plugin
protoc --dart_out=grpc:lib/generated --proto_path=protos protos/game/proto/v1/game_model.proto protos/game/proto/v1/game_images_model.proto protos/game/proto/v1/game_service.proto
```

### Configuration

The gRPC server connection is configured in `lib/modules/game/game_module.dart`:

```dart
GameGrpcDataSource(
  host: 'localhost',  // Change to your server host
  port: 5000,         // Change to your server port
)
```

See [SERVER_SETUP.md](SERVER_SETUP.md) for server configuration details.

## ▶️ Running the Application

Make sure the RetroGate gRPC server is running, then:

```bash
flutter run
```

### With Gamepad

1. Connect your gamepad (Xbox, PlayStation, etc.) via USB or Bluetooth
2. Run the application
3. Use the D-pad or left analog stick to navigate
4. Press A (Xbox) or Cross (PlayStation) to select a game

## ✨ Features

- ✅ **List Games**: View all available games from the RetroGate server
- ✅ **Gamepad Navigation**: Full controller support with visual feedback
- ✅ **Steam Big Picture Design**: Console-friendly interface
- ✅ **Error Handling**: Graceful error handling with user feedback
- ✅ **Clean Architecture**: Separation of concerns with domain, infra, and presentation layers
- ✅ **BLoC Pattern**: State management using BLoC for reactive UI
- ✅ **Dependency Injection**: Using flutter_modular for DI and routing
- ✅ **gRPC Integration**: Communication with RetroGate server using gRPC
- ✅ **Responsive Layout**: 1-6 columns based on screen width

## 📚 Documentation

- **[GAMEPAD_SUPPORT.md](GAMEPAD_SUPPORT.md)**: Gamepad/joystick navigation guide
- **[BLOC_PATTERN.md](BLOC_PATTERN.md)**: Detailed guide on BLoC pattern implementation
- **[GUIDE.md](GUIDE.md)**: Complete usage guide (Portuguese)
- **[SERVER_SETUP.md](SERVER_SETUP.md)**: Server setup instructions
- **[REFACTORING_SUMMARY.md](REFACTORING_SUMMARY.md)**: BLoC refactoring summary

## 🔮 Future Enhancements

- [ ] Auto-scroll for gamepad selection
- [ ] Game details page
- [ ] Implement game installation functionality
- Add search and filter capabilities
- Integrate shortcut management
- Add configuration management UI
- Implement offline mode with local caching
