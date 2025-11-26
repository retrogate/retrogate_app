import 'package:dartz/dartz.dart';
import 'package:retrogate_ui/modules/game/domain/repositories/installed_games_repository.dart';

class LaunchGameUseCase {
  final IInstalledGamesRepository repository;

  LaunchGameUseCase(this.repository);

  Future<Either<Exception, void>> call(String id) {
    return repository.launchGame(id);
  }
}