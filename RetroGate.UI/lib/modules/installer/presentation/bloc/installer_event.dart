import 'package:equatable/equatable.dart';

abstract class InstallerEvent extends Equatable {
  const InstallerEvent();

  @override
  List<Object?> get props => [];
}

class SubscribeToProgressEvent extends InstallerEvent {
  const SubscribeToProgressEvent();
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

class DeleteGameEvent extends InstallerEvent {
  final String gameId;

  const DeleteGameEvent(this.gameId);

  @override
  List<Object?> get props => [gameId];
}
