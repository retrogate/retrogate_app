import 'package:dartz/dartz.dart';
import '../models/game_source.dart';
import '../repositories/available_games_repository.dart';
import '../repositories/installed_games_repository.dart';

class DeleteGameUseCase {
  final IAvailableGamesRepository availableGamesRepository;
  final IInstalledGamesRepository installedGamesRepository;

  DeleteGameUseCase({
    required this.availableGamesRepository,
    required this.installedGamesRepository,
  });

  Future<Either<Exception, void>> call(GameSource source, String id) async {
    switch (source) {
      case GameSource.available:
        return await availableGamesRepository.delete(source, id);
      case GameSource.installed:
        return await installedGamesRepository.delete(source, id);
    }
  }
}
