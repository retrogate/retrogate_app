
import 'package:retrogate_ui/modules/game/domain/models/game_source.dart';

enum GameInstallationMethod {
  extract,
}

class Game {
  final String id;
  final String name;
  final String downloadUrl;
  final String executablePath;
  final String imageHeroUrl;
  final String imagePosterUrl;
  final String imageLogoUrl;
  final GameInstallationMethod installationMethod;
  final GameSource source;
  final String? settingsFile;
  bool isInstalled = false;

  Game({
    required this.id,
    required this.name,
    required this.downloadUrl,
    required this.executablePath,
    required this.imageHeroUrl,
    required this.imagePosterUrl,
    required this.imageLogoUrl,
    required this.installationMethod,
    required this.source,
    this.settingsFile,
    this.isInstalled = false,
  });

  factory Game.fromProto(dynamic proto, GameSource source) {
    return Game(
      id: proto.id,
      name: proto.name,
      downloadUrl: proto.downloadUrl,
      executablePath: proto.executablePath,
      imageHeroUrl: proto.imageHeroUrl,
      imagePosterUrl: proto.imagePosterUrl,
      imageLogoUrl: proto.imageLogoUrl,
      installationMethod: GameInstallationMethod.values[proto.installationMethod.value],
      source: source,
      isInstalled: source == GameSource.installed,
      settingsFile: proto.hasSettingsFile() ? proto.settingsFile : null,
    );
  }
}
