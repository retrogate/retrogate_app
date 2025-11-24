import 'package:dartz/dartz.dart';
import '../models/config.dart';

abstract class IConfigRepository {
  Future<Either<Exception, Config>> getConfig();
  Future<Either<Exception, void>> setConfig(Config config);
}
