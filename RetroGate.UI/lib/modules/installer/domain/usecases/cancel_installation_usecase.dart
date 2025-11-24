import '../repositories/installer_repository.dart';

class CancelInstallationUseCase {
  final InstallerRepository _repository;

  CancelInstallationUseCase(this._repository);

  Future<void> call(String id) async {
    await _repository.cancel(id);
  }
}
