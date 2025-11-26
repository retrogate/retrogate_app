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

  const InstallerDataState(this.progressMap);

  @override
  List<Object?> get props => [progressMap];

  InstallerProgress? getProgress(String gameId) => progressMap[gameId];
  
  bool isInstalling(String gameId) {
    final progress = progressMap[gameId];
    return progress != null && progress.isInProgress;
  }

  InstallerDataState copyWith(Map<String, InstallerProgress>? progressMap) {
    return InstallerDataState(progressMap ?? this.progressMap);
  }
}

class InstallerErrorState extends InstallerState {
  final String message;

  const InstallerErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
