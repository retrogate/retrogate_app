import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrogate_ui/modules/installer/domain/usecases/uninstall_game_usecase.dart';
import '../../domain/models/installer_progress.dart';
import '../../domain/usecases/install_game_usecase.dart';
import '../../domain/usecases/cancel_installation_usecase.dart';
import '../../domain/usecases/subscribe_to_progress_usecase.dart';
import 'installer_event.dart';
import 'installer_state.dart';

class InstallerBloc extends Bloc<InstallerEvent, InstallerState> {
  final SubscribeToProgressUseCase subscribeToProgressUseCase;
  final InstallGameUseCase installGameUseCase;
  final CancelInstallationUseCase cancelInstallationUseCase;
  final UninstallGameUseCase uninstallGameUseCase;

  StreamSubscription? _progressSubscription;

  InstallerBloc({
    required this.subscribeToProgressUseCase,
    required this.installGameUseCase,
    required this.cancelInstallationUseCase,
    required this.uninstallGameUseCase,
  }) : super(const InstallerInitialState()) {
    on<SubscribeToProgressEvent>(_onSubscribeToProgress);
    on<ProgressUpdatedEvent>(_onProgressUpdated);
    on<InstallGameEvent>(_onInstallGame);
    on<CancelInstallationEvent>(_onCancelInstallation);
    on<UninstallGameEvent>(_onUninstallGame);
    
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
        // Add internal event instead of emitting directly
        add(ProgressUpdatedEvent(progress));
      },
      onError: (error) {
        add(ProgressUpdatedEvent(
          InstallerProgress(
            gameId: '',
            state: InstallerProgressState.failed,
            percentage: 0,
            speedInKbPerSec: 0,
          ),
        ));
      },
    );
  }

  void _onProgressUpdated(
    ProgressUpdatedEvent event,
    Emitter<InstallerState> emit,
  ) {
    final currentState = state;
    final progressMap = currentState is InstallerDataState
        ? Map<String, InstallerProgress>.from(currentState.progressMap)
        : <String, InstallerProgress>{};
    
    final pendingGameIds = currentState is InstallerDataState
        ? Set<String>.from(currentState.pendingGameIds)
        : <String>{};
    
    final gameId = event.progress.gameId;
    final newState = event.progress.state;
    
    // Update or add progress for this game
    progressMap[gameId] = event.progress;
    
    // Gerencia o set de pendentes
    if (newState == InstallerProgressState.pending) {
      // Adiciona à lista de pendentes
      pendingGameIds.add(gameId);
    } else if (newState == InstallerProgressState.downloading ||
               newState == InstallerProgressState.extracting ||
               newState == InstallerProgressState.completed ||
               newState == InstallerProgressState.failed ||
               newState == InstallerProgressState.cancelled) {
      // Remove da lista de pendentes quando sai do estado pending
      pendingGameIds.remove(gameId);
    }
    
    emit(InstallerDataState(progressMap, pendingGameIds));
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

  Future<void> _onUninstallGame(
    UninstallGameEvent event,
    Emitter<InstallerState> emit,
  ) async {
    try {
      await uninstallGameUseCase(event.gameId);
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
