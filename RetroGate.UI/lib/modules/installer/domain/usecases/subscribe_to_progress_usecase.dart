import '../models/installer_progress.dart';
import '../repositories/installer_repository.dart';

class SubscribeToProgressUseCase {
  final InstallerRepository _repository;

  SubscribeToProgressUseCase(this._repository);

  Stream<InstallerProgress> call() {
    return _repository.subscribeToProgress();
  }
}
