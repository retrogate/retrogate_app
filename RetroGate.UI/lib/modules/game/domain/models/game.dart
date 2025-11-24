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
  final String? settingsFile;

  Game({
    required this.id,
    required this.name,
    required this.downloadUrl,
    required this.executablePath,
    required this.imageHeroUrl,
    required this.imagePosterUrl,
    required this.imageLogoUrl,
    required this.installationMethod,
    this.settingsFile,
  });

  factory Game.fromProto(dynamic proto) {
    return Game(
      id: proto.id,
      name: proto.name,
      downloadUrl: proto.downloadUrl,
      executablePath: proto.executablePath,
      imageHeroUrl: proto.imageHeroUrl,
      imagePosterUrl: proto.imagePosterUrl,
      imageLogoUrl: proto.imageLogoUrl,
      installationMethod: GameInstallationMethod.values[proto.installationMethod.value],
      settingsFile: proto.hasSettingsFile() ? proto.settingsFile : null,
    );
  }
}
