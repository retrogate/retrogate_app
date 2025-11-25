import 'package:dartz/dartz.dart';
import 'package:retrogate_ui/modules/game/domain/models/game_source.dart';
import '../models/game.dart';
import '../repositories/game_repository.dart';

class GetAllGamesUseCase {
  final IGameRepository repository;

  GetAllGamesUseCase(this.repository);

  Future<Either<Exception, List<Game>>> call(GameSource source) async {
    return await repository.getAll(source);
  }
}
