import 'package:dartz/dartz.dart';
import '../../domain/models/config.dart';
import '../../domain/repository/i_config_repository.dart';
import '../datasources/config_grpc_datasource.dart';
import '../../../../generated/config/proto/v1/config_model.pb.dart';

class ConfigRepository implements IConfigRepository {
  final ConfigGrpcDataSource dataSource;

  ConfigRepository(this.dataSource);

  @override
  Future<Either<Exception, Config>> getConfig() async {
    try {
      final configModel = await dataSource.getConfig();
      final config = _mapToEntity(configModel);
      return Right(config);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> setConfig(Config config) async {
    try {
      final configModel = _mapToModel(config);
      await dataSource.setConfig(configModel);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Config _mapToEntity(ConfigModel model) {
    return Config(
      steamPath: model.steamPath,
      steamUserId: model.steamUserId,
      steamGridDbApiKey: model.steamGridDbApiKey,
    );
  }

  ConfigModel _mapToModel(Config entity) {
    return ConfigModel(
      steamPath: entity.steamPath,
      steamUserId: entity.steamUserId,
      steamGridDbApiKey: entity.steamGridDbApiKey,
    );
  }
}
