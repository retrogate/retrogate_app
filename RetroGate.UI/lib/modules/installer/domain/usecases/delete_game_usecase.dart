import '../repositories/installer_repository.dart';

class DeleteGameUseCase {
  final InstallerRepository _repository;

  DeleteGameUseCase(this._repository);

  Future<void> call(List<String> paths) async {
    await _repository.delete(paths);
  }
}
