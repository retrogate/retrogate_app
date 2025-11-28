import 'package:dartz/dartz.dart';
import 'package:retrogate_ui/modules/game/domain/models/game_source.dart';
import 'package:retrogate_ui/modules/installer/domain/usecases/get_pending_installations.dart';
import '../models/game.dart';
import '../repositories/available_games_repository.dart';
import '../repositories/installed_games_repository.dart';

class GetAllGamesUseCase {
  final IAvailableGamesRepository availableGamesRepository;
  final IInstalledGamesRepository installedGamesRepository;
  final GetPendingInstallations getPendingInstallations;

  GetAllGamesUseCase({
    required this.availableGamesRepository,
    required this.installedGamesRepository,
    required this.getPendingInstallations,
  });

  Future<Either<Exception, List<Game>>> call(GameSource source) async {
    switch (source) {
      case GameSource.available:
        var installedGames = await installedGamesRepository.getAll(GameSource.installed);
        var pendingInstallations = await getPendingInstallations();
        var availableGames = await availableGamesRepository.getAll(source);
        installedGames.fold(
          (l) {}, 
          (r) {
            for (var game in availableGames.getOrElse(() => [])) {
              if (r.any((installedGame) => installedGame.id == game.id)) {
                game.isInstalled = true;
              }
              if (pendingInstallations.contains(game.id)) {
                game.isPending = true;
              }
            }
          });
        return availableGames;
      case GameSource.installed:
        return await installedGamesRepository.getAll(source);
    }
  }
}
