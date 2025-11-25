import 'package:dartz/dartz.dart';
import '../models/game.dart';
import '../models/game_source.dart';
import '../repositories/available_games_repository.dart';
import '../repositories/installed_games_repository.dart';

class UpdateGameUseCase {
  final IAvailableGamesRepository availableGamesRepository;
  final IInstalledGamesRepository installedGamesRepository;

  UpdateGameUseCase({
    required this.availableGamesRepository,
    required this.installedGamesRepository,
  });

  Future<Either<Exception, Game>> call(GameSource source, Game game) async {
    switch (source) {
      case GameSource.available:
        return await availableGamesRepository.update(source, game);
      case GameSource.installed:
        return await installedGamesRepository.update(source, game);
    }
  }
}
