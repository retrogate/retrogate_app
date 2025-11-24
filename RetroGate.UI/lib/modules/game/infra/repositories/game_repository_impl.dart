import 'package:dartz/dartz.dart';
import '../../domain/models/game.dart';
import '../../domain/models/game_images.dart';
import '../../domain/repositories/game_repository.dart';
import '../datasources/game_grpc_datasource.dart';
import '../../../../generated/game/proto/v1/game_model.pb.dart' as proto;

class GameRepository implements IGameRepository {
  final GameGrpcDataSource dataSource;

  GameRepository(this.dataSource);

  @override
  Future<Either<Exception, List<Game>>> getAll() async {
    try {
      final protoGames = await dataSource.getAll();
      final games = protoGames.map((proto) => Game.fromProto(proto)).toList();
      return Right(games);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Game>> getById(String id) async {
    try {
      final protoGame = await dataSource.getById(id);
      final game = Game.fromProto(protoGame);
      return Right(game);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<Game>>> findByName(String name) async {
    try {
      final protoGames = await dataSource.findByName(name);
      final games = protoGames.map((proto) => Game.fromProto(proto)).toList();
      return Right(games);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, GameImages>> getImages(String gameName) async {
    try {
      final protoImages = await dataSource.getImages(gameName);
      final images = GameImages.fromProto(protoImages);
      return Right(images);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Game>> create(Game game) async {
    try {
      final protoGame = _toProto(game);
      final createdProto = await dataSource.create(protoGame);
      final createdGame = Game.fromProto(createdProto);
      return Right(createdGame);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Game>> update(Game game) async {
    try {
      final protoGame = _toProto(game);
      final updatedProto = await dataSource.update(protoGame);
      final updatedGame = Game.fromProto(updatedProto);
      return Right(updatedGame);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, void>> delete(String id) async {
    try {
      await dataSource.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  proto.GameModel _toProto(Game game) {
    return proto.GameModel()
      ..id = game.id
      ..name = game.name
      ..downloadUrl = game.downloadUrl
      ..executablePath = game.executablePath
      ..imageHeroUrl = game.imageHeroUrl
      ..imagePosterUrl = game.imagePosterUrl
      ..imageLogoUrl = game.imageLogoUrl
      ..installationMethod = proto.GameInstallationMethod.values[game.installationMethod.index];
  }
}
