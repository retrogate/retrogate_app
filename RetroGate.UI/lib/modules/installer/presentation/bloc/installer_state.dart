import 'package:equatable/equatable.dart';
import '../../domain/models/installer_progress.dart';

abstract class InstallerState extends Equatable {
  const InstallerState();

  @override
  List<Object?> get props => [];
}

class InstallerInitialState extends InstallerState {
  const InstallerInitialState();
}

class InstallerDataState extends InstallerState {
  final Map<String, InstallerProgress> progressMap;
  final Set<String> pendingGameIds;

  const InstallerDataState(this.progressMap, [this.pendingGameIds = const {}]);

  @override
  List<Object?> get props => [progressMap, pendingGameIds];

  InstallerProgress? getProgress(String gameId) => progressMap[gameId];
  
  bool isInstalling(String gameId) {
    final progress = progressMap[gameId];
    return progress != null && progress.isInProgress;
  }
  
  bool isPending(String gameId) => pendingGameIds.contains(gameId);

  InstallerDataState copyWith({
    Map<String, InstallerProgress>? progressMap,
    Set<String>? pendingGameIds,
  }) {
    return InstallerDataState(
      progressMap ?? this.progressMap,
      pendingGameIds ?? this.pendingGameIds,
    );
  }
}

class InstallerErrorState extends InstallerState {
  final String message;

  const InstallerErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
