import 'package:dartz/dartz.dart';
import 'package:retrogate_ui/modules/game/domain/models/game_source.dart';
import '../../domain/models/game.dart';
import '../../domain/repositories/installed_games_repository.dart';
import '../datasources/game_grpc_datasource.dart';
import '../../../../generated/game/proto/v1/game_model.pb.dart' as proto;
import '../../../../generated/game/proto/v1/game_service.pb.dart' as proto;

class InstalledGamesRepositoryImpl implements IInstalledGamesRepository {
  final GameGrpcDataSource dataSource;

  InstalledGamesRepositoryImpl(this.dataSource);

  @override
  Future<Either<Exception, Game>> create(GameSource source, Game game) async {
    try {
      final protoGame = _toProto(game);
      final createdProto = await dataSource.create(_gameSource(source), protoGame);
      final createdGame = Game.fromProto(createdProto);
      return Right(createdGame);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<Game>>> getAll(GameSource source) async {
    try {
      final protoGames = await dataSource.getAll(_gameSource(source));
      final games = protoGames.map((proto) => Game.fromProto(proto)).toList();
      return Right(games);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Game>> getById(GameSource source, String id) async {
    try {
      final protoGame = await dataSource.getById(_gameSource(source), id);
      final game = Game.fromProto(protoGame);
      return Right(game);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<Game>>> findByName(GameSource source, String name) async {
    try {
      final protoGames = await dataSource.findByName(_gameSource(source), name);
      final games = protoGames.map((proto) => Game.fromProto(proto)).toList();
      return Right(games);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<Game>>> findInstalledGames() async {
    try {
      // TODO: Implementar chamada gRPC específica para jogos instalados
      // Por enquanto, retorna lista vazia
      return const Right([]);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Game>> update(GameSource source, Game game) async {
    try {
      final protoGame = _toProto(game);
      final updatedProto = await dataSource.update(_gameSource(source), protoGame);
      final updatedGame = Game.fromProto(updatedProto);
      return Right(updatedGame);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, void>> delete(GameSource source, String id) async {
    try {
      await dataSource.delete(_gameSource(source), id);
      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  proto.GameModel _toProto(Game game) {
    final protoGame = proto.GameModel()
      ..id = game.id
      ..name = game.name
      ..downloadUrl = game.downloadUrl
      ..executablePath = game.executablePath
      ..imageHeroUrl = game.imageHeroUrl
      ..imagePosterUrl = game.imagePosterUrl
      ..imageLogoUrl = game.imageLogoUrl
      ..installationMethod = proto.GameInstallationMethod.values[game.installationMethod.index];
    
    if (game.settingsFile != null) {
      protoGame.settingsFile = game.settingsFile!;
    }
    
    return protoGame;
  }

  proto.GameSource _gameSource(GameSource source) {
    return proto.GameSource.values[source.index];
  }
}
