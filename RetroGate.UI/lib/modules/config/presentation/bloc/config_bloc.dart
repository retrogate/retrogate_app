import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/config.dart';
import '../../domain/usecases/get_config_usecase.dart';
import '../../domain/usecases/set_config_usecase.dart';
import 'config_event.dart';
import 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final GetConfigUseCase getConfigUseCase;
  final SetConfigUseCase setConfigUseCase;

  Config? _currentConfig;

  ConfigBloc({
    required this.getConfigUseCase,
    required this.setConfigUseCase,
  }) : super(ConfigInitial()) {
    on<LoadConfig>(_onLoadConfig);
    on<UpdateSteamPath>(_onUpdateSteamPath);
    on<UpdateSteamUserId>(_onUpdateSteamUserId);
    on<UpdateSteamGridDbApiKey>(_onUpdateSteamGridDbApiKey);
    on<SaveConfig>(_onSaveConfig);
  }

  Future<void> _onLoadConfig(LoadConfig event, Emitter<ConfigState> emit) async {
    emit(ConfigLoading());

    final result = await getConfigUseCase();

    result.fold(
      (error) => emit(ConfigError(error.toString())),
      (config) {
        _currentConfig = config;
        emit(ConfigLoaded(config));
      },
    );
  }

  void _onUpdateSteamPath(UpdateSteamPath event, Emitter<ConfigState> emit) {
    if (_currentConfig != null) {
      _currentConfig = _currentConfig!.copyWith(steamPath: event.steamPath);
      emit(ConfigLoaded(_currentConfig!));
    }
  }

  void _onUpdateSteamUserId(UpdateSteamUserId event, Emitter<ConfigState> emit) {
    if (_currentConfig != null) {
      _currentConfig = _currentConfig!.copyWith(steamUserId: event.steamUserId);
      emit(ConfigLoaded(_currentConfig!));
    }
  }

  void _onUpdateSteamGridDbApiKey(UpdateSteamGridDbApiKey event, Emitter<ConfigState> emit) {
    if (_currentConfig != null) {
      _currentConfig = _currentConfig!.copyWith(steamGridDbApiKey: event.apiKey);
      emit(ConfigLoaded(_currentConfig!));
    }
  }

  Future<void> _onSaveConfig(SaveConfig event, Emitter<ConfigState> emit) async {
    emit(ConfigSaving(event.config));

    final result = await setConfigUseCase(event.config);

    result.fold(
      (error) => emit(ConfigError(error.toString())),
      (_) {
        _currentConfig = event.config;
        emit(ConfigSaved(event.config));
      },
    );
  }
}
