import 'package:flutter_modular/flutter_modular.dart';
import 'domain/repositories/game_repository.dart';
import 'domain/usecases/get_all_games_usecase.dart';
import 'domain/usecases/create_game_usecase.dart';
import 'domain/usecases/get_game_images_usecase.dart';
import 'infra/datasources/game_grpc_datasource.dart';
import 'infra/repositories/game_repository_impl.dart';
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

    // Repository
    i.addLazySingleton<IGameRepository>(
      () => GameRepository(i.get<GameGrpcDataSource>()),
    );

    // UseCases
    i.addLazySingleton<GetAllGamesUseCase>(
      () => GetAllGamesUseCase(i.get<IGameRepository>()),
    );
    
    i.addLazySingleton<CreateGameUseCase>(
      () => CreateGameUseCase(i.get<IGameRepository>()),
    );
    
    i.addLazySingleton<GetGameImagesUseCase>(
      () => GetGameImagesUseCase(i.get<IGameRepository>()),
    );

    // BLoC
    i.add<GamesBloc>(
      () => GamesBloc(
        getAllGamesUseCase: i.get<GetAllGamesUseCase>(),
        createGameUseCase: i.get<CreateGameUseCase>(),
        getGameImagesUseCase: i.get<GetGameImagesUseCase>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const GamesListPage());
    r.child('/add', child: (context) => const AddGamePage());
  }
}
