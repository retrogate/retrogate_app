import 'package:retrogate_ui/modules/installer/domain/repositories/installer_repository.dart';

class UninstallGameUseCase {
  final InstallerRepository repository;

  UninstallGameUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.uninstall(id);
  }
}