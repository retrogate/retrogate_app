import 'package:dartz/dartz.dart';
import '../models/game_source.dart';
import '../models/game.dart';
import '../models/game_images.dart';

abstract class IAvailableGamesRepository {
  Future<Either<Exception, Game>> create(GameSource source, Game game);
  Future<Either<Exception, Game>> getById(GameSource source, String id);
  Future<Either<Exception, List<Game>>> getAll(GameSource source);
  Future<Either<Exception, List<Game>>> findByName(GameSource source, String name);
  Future<Either<Exception, GameImages>> getImages(String gameName);
  Future<Either<Exception, Game>> update(GameSource source, Game game);
  Future<Either<Exception, void>> delete(GameSource source, String id);
}
