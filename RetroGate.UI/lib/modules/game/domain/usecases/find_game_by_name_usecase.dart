import 'package:dartz/dartz.dart';
import '../models/game.dart';
import '../models/game_source.dart';
import '../repositories/available_games_repository.dart';
import '../repositories/installed_games_repository.dart';

class FindGameByNameUseCase {
  final IAvailableGamesRepository availableGamesRepository;
  final IInstalledGamesRepository installedGamesRepository;

  FindGameByNameUseCase({
    required this.availableGamesRepository,
    required this.installedGamesRepository,
  });

  Future<Either<Exception, List<Game>>> call(GameSource source, String name) async {
    switch (source) {
      case GameSource.available:
        return await availableGamesRepository.findByName(source, name);
      case GameSource.installed:
        return await installedGamesRepository.findByName(source, name);
    }
  }
}
