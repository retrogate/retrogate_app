import 'package:dartz/dartz.dart';
import '../models/game.dart';
import '../repositories/game_repository.dart';

class GetAllGamesUseCase {
  final IGameRepository repository;

  GetAllGamesUseCase(this.repository);

  Future<Either<Exception, List<Game>>> call() async {
    return await repository.getAll();
  }
}
