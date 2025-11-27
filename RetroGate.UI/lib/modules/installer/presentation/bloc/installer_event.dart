import 'package:equatable/equatable.dart';
import '../../domain/models/installer_progress.dart';

abstract class InstallerEvent extends Equatable {
  const InstallerEvent();

  @override
  List<Object?> get props => [];
}

class SubscribeToProgressEvent extends InstallerEvent {
  const SubscribeToProgressEvent();
}

class ProgressUpdatedEvent extends InstallerEvent {
  final InstallerProgress progress;

  const ProgressUpdatedEvent(this.progress);

  @override
  List<Object?> get props => [progress];
}

class InstallGameEvent extends InstallerEvent {
  final String gameId;

  const InstallGameEvent(this.gameId);

  @override
  List<Object?> get props => [gameId];
}

class CancelInstallationEvent extends InstallerEvent {
  final String gameId;

  const CancelInstallationEvent(this.gameId);

  @override
  List<Object?> get props => [gameId];
}

// class DeleteGameEvent extends InstallerEvent {
//   final String gameId;

//   const DeleteGameEvent(this.gameId);

//   @override
//   List<Object?> get props => [gameId];
// }

class UninstallGameEvent extends InstallerEvent {
  final String gameId;

  const UninstallGameEvent(this.gameId);

  @override
  List<Object?> get props => [gameId];
}
