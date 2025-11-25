import 'package:dartz/dartz.dart';
import 'package:retrogate_ui/modules/game/domain/models/game_source.dart';
import '../models/game.dart';
import '../repositories/available_games_repository.dart';
import '../repositories/installed_games_repository.dart';

class GetAllGamesUseCase {
  final IAvailableGamesRepository availableGamesRepository;
  final IInstalledGamesRepository installedGamesRepository;

  GetAllGamesUseCase({
    required this.availableGamesRepository,
    required this.installedGamesRepository,
  });

  Future<Either<Exception, List<Game>>> call(GameSource source) async {
    switch (source) {
      case GameSource.available:
        return await availableGamesRepository.getAll(source);
      case GameSource.installed:
        return await installedGamesRepository.getAll(source);
    }
  }
}
