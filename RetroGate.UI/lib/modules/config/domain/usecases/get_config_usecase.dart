import 'package:dartz/dartz.dart';
import '../models/config.dart';
import '../repository/i_config_repository.dart';

class GetConfigUseCase {
  final IConfigRepository repository;

  GetConfigUseCase(this.repository);

  Future<Either<Exception, Config>> call() async {
    return await repository.getConfig();
  }
}
