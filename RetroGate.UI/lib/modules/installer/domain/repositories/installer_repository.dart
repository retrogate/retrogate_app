import '../models/installer_progress.dart';

abstract class InstallerRepository {
  /// Install a game
  Future<String> install({
    required String gameId,
    bool replace = false,
    bool restartSteam = false,
  });

  /// Uninstall a game
  Future<void> uninstall(String id);

  /// Cancel installation
  Future<void> cancel(String id);

  /// Subscribe to installation progress events
  Stream<InstallerProgress> subscribeToProgress();
}
