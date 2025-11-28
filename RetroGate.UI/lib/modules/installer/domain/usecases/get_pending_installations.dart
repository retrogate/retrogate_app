import '../repositories/installer_repository.dart';

class GetPendingInstallations {
  final InstallerRepository repository;

  GetPendingInstallations(this.repository);

  Future<List<String>> call() {
    return repository.getPendingInstallations();
  }
}