import 'package:dartz/dartz.dart';
import '../models/config.dart';
import '../repository/i_config_repository.dart';

class SetConfigUseCase {
  final IConfigRepository repository;

  SetConfigUseCase(this.repository);

  Future<Either<Exception, void>> call(Config config) async {
    return await repository.setConfig(config);
  }
}
