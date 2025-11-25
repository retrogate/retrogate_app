import 'package:dartz/dartz.dart';
import 'package:retrogate_ui/modules/game/domain/models/game_source.dart';
import '../models/game.dart';
import '../repositories/available_games_repository.dart';

class GetAllGamesUseCase {
  final IAvailableGamesRepository repository;

  GetAllGamesUseCase(this.repository);

  Future<Either<Exception, List<Game>>> call(GameSource source) async {
    return await repository.getAll(source);
  }
}
