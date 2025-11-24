import '../models/installer_progress.dart';

abstract class InstallerRepository {
  /// Install a game
  Future<String> install({
    required String gameId,
    bool replace = false,
    bool restartSteam = false,
  });

  /// Delete game files
  Future<void> delete(List<String> paths);

  /// Cancel installation
  Future<void> cancel(String id);

  /// Subscribe to installation progress events
  Stream<InstallerProgress> subscribeToProgress();
}
