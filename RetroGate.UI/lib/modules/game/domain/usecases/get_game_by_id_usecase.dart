import 'package:dartz/dartz.dart';
import '../models/game.dart';
import '../models/game_source.dart';
import '../repositories/available_games_repository.dart';
import '../repositories/installed_games_repository.dart';

class GetGameByIdUseCase {
  final IAvailableGamesRepository availableGamesRepository;
  final IInstalledGamesRepository installedGamesRepository;

  GetGameByIdUseCase({
    required this.availableGamesRepository,
    required this.installedGamesRepository,
  });

  Future<Either<Exception, Game>> call(GameSource source, String id) async {
    switch (source) {
      case GameSource.available:
        return await availableGamesRepository.getById(source, id);
      case GameSource.installed:
        return await installedGamesRepository.getById(source, id);
    }
  }
}
