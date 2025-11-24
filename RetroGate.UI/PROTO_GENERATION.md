# Protocol Buffers Code Generation

This project uses Protocol Buffers (proto3) for gRPC communication between the Flutter client and C# server.

## Structure

- **Definitions**: `../RetroGate.Protos/` (single source of truth)
- **Generated Code**: `lib/generated/` (automatically generated)
- **Dependencies**: `protos/google/protobuf/` (common protobuf files)

## Makefile

The project includes a Makefile to facilitate Dart code generation from `.proto` files.

### Available Commands

```bash
# Show help
make help

# Generate all modules
make gen

# Generate specific module
make gen-game        # Game module
make gen-config      # Configuration module
make gen-installer   # Installer module
make gen-shortcut    # Shortcut module

# Clean generated files
make clean
```

### Typical Usage

After modifying any `.proto` file in `RetroGate.Protos`:

```bash
cd RetroGate.UI
make gen
```

Or to regenerate only a specific module:

```bash
make gen-installer
```

## Modules

### Game
- `game_model.proto` - Game data model
- `game_images_model.proto` - Game images model
- `game_service.proto` - Game gRPC service

### Config
- `config_model.proto` - Configuration model
- `config_service.proto` - Configuration gRPC service

### Installer
- `installer_event_model.proto` - Installation progress events
- `installer_service.proto` - Installer gRPC service

### Shortcut
- `shortcut_model.proto` - Shortcut model
- `shortcut_service.proto` - Shortcut gRPC service

## Requirements

- `protoc` - Protocol Buffers compiler
- `protoc-gen-dart` - Dart plugin for protoc

### Installation

```bash
# Install Dart plugin for protoc
dart pub global activate protoc_plugin
```

## Troubleshooting

### Error: "protoc: command not found"

Install the Protocol Buffers compiler:
- Windows: `choco install protoc`
- macOS: `brew install protobuf`
- Linux: `apt-get install protobuf-compiler`

### Error: "protoc-gen-dart: program not found"

Make sure the Dart plugin is installed and in PATH:

```bash
dart pub global activate protoc_plugin
# Add to PATH: %USERPROFILE%\AppData\Local\Pub\Cache\bin
```

## Generated Code Structure

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

## Important Notes

1. **Don't edit generated files**: All files in `lib/generated/` are automatically generated
2. **Single source**: Proto definitions are in `RetroGate.Protos`
3. **Versioning**: Generated files should not be committed (already in .gitignore)
4. **Synchronization**: Run `make gen` after each pull that modifies the protos
