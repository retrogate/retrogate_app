import '../../domain/models/installer_progress.dart';
import '../../domain/repositories/installer_repository.dart';
import '../datasources/installer_grpc_datasource.dart';

class InstallerRepositoryImpl implements InstallerRepository {
  final InstallerGrpcDataSource _dataSource;

  InstallerRepositoryImpl(this._dataSource);

  @override
  Future<String> install({
    required String gameId,
    bool replace = false,
    bool restartSteam = false,
  }) async {
    return await _dataSource.install(
      gameId: gameId,
      replace: replace,
      restartSteam: restartSteam,
    );
  }

  @override
  Future<void> delete(List<String> paths) async {
    await _dataSource.delete(paths);
  }

  @override
  Future<void> cancel(String id) async {
    await _dataSource.cancel(id);
  }

  @override
  Stream<InstallerProgress> subscribeToProgress() {
    return _dataSource.subscribeEvents().map((event) {
      // Handle different event types (currently only progress_changed)
      if (event.hasProgressChanged()) {
        return InstallerProgress.fromProto(event.progressChanged);
      }
      
      // Default fallback (shouldn't happen with current proto)
      throw Exception('Unknown installer event type');
    });
  }
}
