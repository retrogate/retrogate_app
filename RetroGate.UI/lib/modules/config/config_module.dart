import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'domain/repository/i_config_repository.dart';
import 'domain/usecases/get_config_usecase.dart';
import 'domain/usecases/set_config_usecase.dart';
import 'infra/datasources/config_grpc_datasource.dart';
import 'infra/repository/config_repository.dart';
import 'presentation/bloc/config_bloc.dart';
import 'presentation/config_page.dart';

class ConfigModule extends Module {
  @override
  void binds(Injector i) {
    // DataSource
    i.addLazySingleton<ConfigGrpcDataSource>(
      () => ConfigGrpcDataSource(
        host: 'localhost',
        port: 5000,
      ),
    );

    // Repository
    i.addLazySingleton<IConfigRepository>(
      () => ConfigRepository(i.get<ConfigGrpcDataSource>()),
    );

    // UseCases
    i.addLazySingleton<GetConfigUseCase>(
      () => GetConfigUseCase(i.get<IConfigRepository>()),
    );
    i.addLazySingleton<SetConfigUseCase>(
      () => SetConfigUseCase(i.get<IConfigRepository>()),
    );

    // BLoC
    i.add<ConfigBloc>(
      () => ConfigBloc(
        getConfigUseCase: i.get<GetConfigUseCase>(),
        setConfigUseCase: i.get<SetConfigUseCase>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (context) => Modular.get<ConfigBloc>(),
        child: const ConfigPage(),
      ),
    );
  }
}
