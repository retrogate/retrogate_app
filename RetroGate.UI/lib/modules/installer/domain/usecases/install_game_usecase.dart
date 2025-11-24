import '../repositories/installer_repository.dart';

class InstallGameUseCase {
  final InstallerRepository _repository;

  InstallGameUseCase(this._repository);

  Future<String> call({
    required String gameId,
    bool replace = false,
    bool restartSteam = false,
  }) async {
    return await _repository.install(
      gameId: gameId,
      replace: replace,
      restartSteam: restartSteam,
    );
  }
}
