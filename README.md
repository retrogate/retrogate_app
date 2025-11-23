# RetroGate

RetroGate is a .NET 8.0 solution for managing retro gaming installations and Steam shortcuts. It provides both a gRPC service and a CLI interface for managing games, installers, and Steam shortcuts.

## 🎮 Overview

RetroGate helps you automate the installation and management of retro games by:
- **Game Management**: Download, install, and track retro games
- **Steam Integration**: Create and manage Steam shortcuts for your games
- **Automated Installation**: Support for different installation methods (extraction, etc.)
- **Image Management**: Automatically fetch and manage game artwork (hero images, posters, logos)
- **Configuration Management**: Centralized configuration for all your retro gaming needs

## 🏗️ Architecture

The solution is composed of four main projects:

### RetroGate.SDK
Core business logic and domain models implementing Clean Architecture principles:
- **Domain Layer**: Models, repositories, and use case interfaces
- **Infrastructure Layer**: Repository and use case implementations
- **Modules**:
  - `Core`: Configuration management
  - `Game`: Game catalog and installation management
  - `Installer`: Game installation workflows
  - `Shortcut`: Steam shortcut management

### RetroGate.Grpc
gRPC server exposing RetroGate functionality via Protocol Buffers:
- ASP.NET Core Web application
- gRPC service implementations
- Service reflection support for easy debugging
- RESTful configuration management

### RetroGate.Protos
Protocol Buffer definitions for gRPC services:
- Config service definitions
- Game service definitions
- Installer service definitions
- Shortcut service definitions

### RetroGate.CLI
Command-line interface for RetroGate:
- Modular CLI architecture
- Shortcuts management commands
- Installation commands
- Interactive game installation

## 🚀 Getting Started

### Prerequisites
- .NET 8.0 SDK or later
- Windows OS (for Steam shortcut management)

### Building the Solution

```powershell
# Clone the repository
git clone <repository-url>
cd RetroGate

# Restore dependencies and build
dotnet restore
dotnet build
```

### Running the gRPC Server

```powershell
# Run the gRPC server
dotnet run --project RetroGate.Grpc

# Or use the watch task for development
dotnet watch run --project RetroGate.Grpc
```

The gRPC server will start on the configured ports (check `appsettings.json`).

### Using the CLI

```powershell
# Build and run the CLI
dotnet run --project RetroGate.CLI -- <module> <command> [options]

# Examples:
# List Steam shortcuts
dotnet run --project RetroGate.CLI -- shortcuts list shortcuts.vdf

# Install a game
dotnet run --project RetroGate.CLI -- install game <game-id>
```

## 📋 Available Tasks

The solution includes predefined VS Code tasks:

- `build-solution` (default): Build the entire solution
- `build-cli`: Build the CLI project
- `build-grpc`: Build the gRPC server
- `watch-cli`: Run CLI with hot reload
- `watch-grpc`: Run gRPC server with hot reload
- `clean`: Clean build artifacts

## 🔧 Configuration

RetroGate uses JSON configuration files:

- `retrogate_config.json`: Main configuration file
- `games.json`: Game catalog definitions
- `appsettings.json`: gRPC server settings
- `appsettings.Development.json`: Development-specific settings

## 📦 Dependencies

### Key Libraries
- **LanguageExt.Core**: Functional programming features (Either, Option, etc.)
- **Grpc.AspNetCore**: gRPC server implementation
- **craftersmine.SteamGridDB.Net**: SteamGridDB integration for game artwork

## 🎯 Use Cases

### Game Management
- Create and register new games
- Find games by name or ID
- Update game information
- Retrieve all games in the catalog

### Installation Management
- Download game files
- Extract game archives
- Track installation progress
- Configure installation paths

### Shortcut Management
- Create Steam shortcuts for games
- List existing shortcuts
- Add game artwork to Steam
- Manage shortcut properties

### Configuration
- Get/set RetroGate configuration
- Manage game library paths
- Configure Steam integration

## 🏛️ Project Structure

```
RetroGate/
├── RetroGate.SDK/          # Core business logic and domain models
│   ├── Core/               # Configuration and shared functionality
│   ├── Game/               # Game management domain
│   ├── Installer/          # Installation workflows
│   └── Shortcut/           # Steam shortcut management
├── RetroGate.Grpc/         # gRPC server implementation
│   ├── Services/           # gRPC service implementations
│   └── Extensions/         # Helper extensions
├── RetroGate.Protos/       # Protocol Buffer definitions
│   ├── config/proto/v1/    # Config service protos
│   ├── game/proto/v1/      # Game service protos
│   ├── installer/proto/v1/ # Installer service protos
│   └── shortcut/proto/v1/  # Shortcut service protos
└── RetroGate.CLI/          # Command-line interface
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## 📄 License

[Add your license information here]

## 🔗 Links

- [gRPC Documentation](https://grpc.io/docs/)
- [.NET 8.0 Documentation](https://docs.microsoft.com/en-us/dotnet/)
- [SteamGridDB](https://www.steamgriddb.com/)

---

Built with ❤️ using .NET 8.0 and gRPC
