import 'package:dartz/dartz.dart';
import '../models/game.dart';
import '../repositories/installed_games_repository.dart';

class GetInstalledGamesUseCase {
  final IInstalledGamesRepository repository;

  GetInstalledGamesUseCase(this.repository);

  Future<Either<Exception, List<Game>>> call() async {
    return await repository.findInstalledGames();
  }
}
