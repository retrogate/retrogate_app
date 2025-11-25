import 'package:dartz/dartz.dart';
import 'package:retrogate_ui/modules/game/domain/models/game_source.dart';
import '../models/game.dart';
import '../repositories/game_repository.dart';

class CreateGameUseCase {
  final IGameRepository repository;

  CreateGameUseCase(this.repository);

  Future<Either<Exception, Game>> call(GameSource source, Game game) async {
    return await repository.create(source, game);
  }
}
