import 'package:flutter_modular/flutter_modular.dart';
import 'package:retrogate_ui/modules/game/domain/usecases/launch_game_usecase.dart';
import 'package:retrogate_ui/modules/installer/domain/usecases/get_pending_installations.dart';
import 'domain/repositories/available_games_repository.dart';
import 'domain/repositories/installed_games_repository.dart';
import 'domain/usecases/get_all_games_usecase.dart';
import 'domain/usecases/create_game_usecase.dart';
import 'domain/usecases/update_game_usecase.dart';
import 'domain/usecases/delete_game_usecase.dart';
import 'domain/usecases/get_game_by_id_usecase.dart';
import 'domain/usecases/find_game_by_name_usecase.dart';
import 'domain/usecases/get_game_images_usecase.dart';
import 'domain/usecases/get_installed_games_usecase.dart';
import 'infra/datasources/game_grpc_datasource.dart';
import 'infra/repositories/available_games_repository_impl.dart';
import 'infra/repositories/installed_games_repository_impl.dart';
import 'presentation/bloc/games_bloc.dart';
import 'presentation/games_list_page.dart';
import 'presentation/add_game_page.dart';

class GameModule extends Module {
  @override
  void binds(Injector i) {
    // DataSource
    i.addLazySingleton<GameGrpcDataSource>(
      () => GameGrpcDataSource(
        host: 'localhost',
        port: 5000,
      ),
    );

    // Repositories
    i.addLazySingleton<IAvailableGamesRepository>(
      () => AvailableGamesRepositoryImpl(i.get<GameGrpcDataSource>()),
    );
    
    i.addLazySingleton<IInstalledGamesRepository>(
      () => InstalledGamesRepositoryImpl(i.get<GameGrpcDataSource>()),
    );

    // UseCases - Dual repository (switch on GameSource)
    i.addLazySingleton<GetAllGamesUseCase>(
      () => GetAllGamesUseCase(
        availableGamesRepository: i.get<IAvailableGamesRepository>(),
        installedGamesRepository: i.get<IInstalledGamesRepository>(),
        getPendingInstallations: Modular.get<GetPendingInstallations>(),
      ),
    );
    
    i.addLazySingleton<CreateGameUseCase>(
      () => CreateGameUseCase(
        availableGamesRepository: i.get<IAvailableGamesRepository>(),
        installedGamesRepository: i.get<IInstalledGamesRepository>(),
      ),
    );
    
    i.addLazySingleton<UpdateGameUseCase>(
      () => UpdateGameUseCase(
        availableGamesRepository: i.get<IAvailableGamesRepository>(),
        installedGamesRepository: i.get<IInstalledGamesRepository>(),
      ),
    );
    
    i.addLazySingleton<DeleteGameUseCase>(
      () => DeleteGameUseCase(
        availableGamesRepository: i.get<IAvailableGamesRepository>(),
        installedGamesRepository: i.get<IInstalledGamesRepository>(),
      ),
    );
    
    i.addLazySingleton<GetGameByIdUseCase>(
      () => GetGameByIdUseCase(
        availableGamesRepository: i.get<IAvailableGamesRepository>(),
        installedGamesRepository: i.get<IInstalledGamesRepository>(),
      ),
    );
    
    i.addLazySingleton<FindGameByNameUseCase>(
      () => FindGameByNameUseCase(
        availableGamesRepository: i.get<IAvailableGamesRepository>(),
        installedGamesRepository: i.get<IInstalledGamesRepository>(),
      ),
    );
    
    i.addLazySingleton<LaunchGameUseCase>(
      () => LaunchGameUseCase(i.get<IInstalledGamesRepository>()),
    );

    // UseCases - Single repository (no switching)
    i.addLazySingleton<GetGameImagesUseCase>(
      () => GetGameImagesUseCase(i.get<IAvailableGamesRepository>()),
    );
    
    i.addLazySingleton<GetInstalledGamesUseCase>(
      () => GetInstalledGamesUseCase(i.get<IInstalledGamesRepository>()),
    );

    // BLoCs
    i.add<GamesBloc>(
      () => GamesBloc(
        getAllGamesUseCase: i.get<GetAllGamesUseCase>(),
        createGameUseCase: i.get<CreateGameUseCase>(),
        getGameImagesUseCase: i.get<GetGameImagesUseCase>(),
        launchGameUseCase: i.get<LaunchGameUseCase>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const GamesListPage());
    r.child('/add', child: (context) => const AddGamePage());
  }
}
