import 'package:dartz/dartz.dart';
import '../models/game.dart';
import '../repositories/game_repository.dart';

class CreateGameUseCase {
  final IGameRepository repository;

  CreateGameUseCase(this.repository);

  Future<Either<Exception, Game>> call(Game game) async {
    return await repository.create(game);
  }
}
