import 'package:dartz/dartz.dart';
import '../models/game_source.dart';
import '../models/game.dart';

abstract class IInstalledGamesRepository {
  Future<Either<Exception, Game>> create(GameSource source, Game game);
  Future<Either<Exception, Game>> getById(GameSource source, String id);
  Future<Either<Exception, List<Game>>> getAll(GameSource source);
  Future<Either<Exception, List<Game>>> findByName(GameSource source, String name);
  Future<Either<Exception, List<Game>>> findInstalledGames();
  Future<Either<Exception, Game>> update(GameSource source, Game game);
  Future<Either<Exception, void>> delete(GameSource source, String id);
  Future<Either<Exception, void>> launchGame(String id);
}
