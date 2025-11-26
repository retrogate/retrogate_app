import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/installer_progress.dart';
import '../../domain/usecases/install_game_usecase.dart';
import '../../domain/usecases/cancel_installation_usecase.dart';
import '../../domain/usecases/delete_game_usecase.dart';
import '../../domain/usecases/subscribe_to_progress_usecase.dart';
import 'installer_event.dart';
import 'installer_state.dart';

class InstallerBloc extends Bloc<InstallerEvent, InstallerState> {
  final SubscribeToProgressUseCase subscribeToProgressUseCase;
  final InstallGameUseCase installGameUseCase;
  final CancelInstallationUseCase cancelInstallationUseCase;
  final DeleteGameUseCase deleteGameUseCase;

  StreamSubscription? _progressSubscription;

  InstallerBloc({
    required this.subscribeToProgressUseCase,
    required this.installGameUseCase,
    required this.cancelInstallationUseCase,
    required this.deleteGameUseCase,
  }) : super(const InstallerInitialState()) {
    on<SubscribeToProgressEvent>(_onSubscribeToProgress);
    on<InstallGameEvent>(_onInstallGame);
    on<CancelInstallationEvent>(_onCancelInstallation);
    on<DeleteGameEvent>(_onDeleteGame);
    
    // Auto-subscribe on initialization
    add(const SubscribeToProgressEvent());
  }

  void _onSubscribeToProgress(
    SubscribeToProgressEvent event,
    Emitter<InstallerState> emit,
  ) {
    _progressSubscription?.cancel();
    
    _progressSubscription = subscribeToProgressUseCase().listen(
      (progress) {
        final currentState = state;
        final progressMap = currentState is InstallerDataState
            ? Map<String, InstallerProgress>.from(currentState.progressMap)
            : <String, InstallerProgress>{};
        
        // Update or add progress for this game
        progressMap[progress.gameId] = progress;
        
        emit(InstallerDataState(progressMap));
      },
      onError: (error) {
        emit(InstallerErrorState(error.toString()));
      },
    );
  }

  Future<void> _onInstallGame(
    InstallGameEvent event,
    Emitter<InstallerState> emit,
  ) async {
    try {
      await installGameUseCase(gameId: event.gameId);
      // Installation started, progress will come through stream
    } catch (error) {
      emit(InstallerErrorState(error.toString()));
    }
  }

  Future<void> _onCancelInstallation(
    CancelInstallationEvent event,
    Emitter<InstallerState> emit,
  ) async {
    try {
      await cancelInstallationUseCase(event.gameId);
      // Cancellation requested
    } catch (error) {
      emit(InstallerErrorState(error.toString()));
    }
  }

  Future<void> _onDeleteGame(
    DeleteGameEvent event,
    Emitter<InstallerState> emit,
  ) async {
    try {
      await deleteGameUseCase([event.gameId]);
      // Game deleted
    } catch (error) {
      emit(InstallerErrorState(error.toString()));
    }
  }

  @override
  Future<void> close() {
    _progressSubscription?.cancel();
    return super.close();
  }
}
