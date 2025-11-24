import 'package:dartz/dartz.dart';
import '../models/game.dart';
import '../models/game_images.dart';

abstract class IGameRepository {
  Future<Either<Exception, List<Game>>> getAll();
  Future<Either<Exception, Game>> getById(String id);
  Future<Either<Exception, List<Game>>> findByName(String name);
  Future<Either<Exception, GameImages>> getImages(String gameName);
  Future<Either<Exception, Game>> create(Game game);
  Future<Either<Exception, Game>> update(Game game);
  Future<Either<Exception, void>> delete(String id);
}
