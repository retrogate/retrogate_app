import 'package:dartz/dartz.dart';
import '../models/game_images.dart';
import '../repositories/available_games_repository.dart';

class GetGameImagesUseCase {
  final IAvailableGamesRepository repository;

  GetGameImagesUseCase(this.repository);

  Future<Either<Exception, GameImages>> call(String gameName) async {
    return await repository.getImages(gameName);
  }
}
