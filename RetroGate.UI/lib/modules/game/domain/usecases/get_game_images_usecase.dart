import 'package:dartz/dartz.dart';
import '../models/game_images.dart';
import '../repositories/game_repository.dart';

class GetGameImagesUseCase {
  final IGameRepository repository;

  GetGameImagesUseCase(this.repository);

  Future<Either<Exception, GameImages>> call(String gameName) async {
    return await repository.getImages(gameName);
  }
}
