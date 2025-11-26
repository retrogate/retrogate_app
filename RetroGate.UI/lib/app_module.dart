import 'package:flutter_modular/flutter_modular.dart';
import 'modules/game/game_module.dart';
import 'modules/config/config_module.dart';
import 'modules/installer/domain/repositories/installer_repository.dart';
import 'modules/installer/domain/usecases/install_game_usecase.dart';
import 'modules/installer/domain/usecases/cancel_installation_usecase.dart';
import 'modules/installer/domain/usecases/delete_game_usecase.dart';
import 'modules/installer/domain/usecases/subscribe_to_progress_usecase.dart';
import 'modules/installer/infra/datasources/installer_grpc_datasource.dart';
import 'modules/installer/infra/repositories/installer_repository_impl.dart';
import 'modules/installer/presentation/bloc/installer_bloc.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    // Global Installer DataSource
    i.addLazySingleton<InstallerGrpcDataSource>(
      () => InstallerGrpcDataSource(
        host: 'localhost',
        port: 5000,
      ),
    );

    // Global Installer Repository
    i.addLazySingleton<InstallerRepository>(
      () => InstallerRepositoryImpl(i.get<InstallerGrpcDataSource>()),
    );

    // Global Installer UseCases
    i.addLazySingleton<SubscribeToProgressUseCase>(
      () => SubscribeToProgressUseCase(i.get<InstallerRepository>()),
    );
    
    i.addLazySingleton<InstallGameUseCase>(
      () => InstallGameUseCase(i.get<InstallerRepository>()),
    );
    
    i.addLazySingleton<CancelInstallationUseCase>(
      () => CancelInstallationUseCase(i.get<InstallerRepository>()),
    );
    
    i.addLazySingleton<DeleteGameUseCase>(
      () => DeleteGameUseCase(i.get<InstallerRepository>()),
    );

    // Global InstallerBloc (singleton - starts on app init)
    i.addSingleton<InstallerBloc>(
      () => InstallerBloc(
        subscribeToProgressUseCase: i.get<SubscribeToProgressUseCase>(),
        installGameUseCase: i.get<InstallGameUseCase>(),
        cancelInstallationUseCase: i.get<CancelInstallationUseCase>(),
        deleteGameUseCase: i.get<DeleteGameUseCase>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.module('/games', module: GameModule());
    r.module('/config', module: ConfigModule());
    r.redirect('/', to: '/games/');
  }
}
