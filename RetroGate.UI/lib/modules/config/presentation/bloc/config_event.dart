import 'package:equatable/equatable.dart';
import '../../domain/models/config.dart';

abstract class ConfigEvent extends Equatable {
  const ConfigEvent();

  @override
  List<Object?> get props => [];
}

class LoadConfig extends ConfigEvent {}

class UpdateSteamPath extends ConfigEvent {
  final String steamPath;

  const UpdateSteamPath(this.steamPath);

  @override
  List<Object?> get props => [steamPath];
}

class UpdateSteamUserId extends ConfigEvent {
  final String steamUserId;

  const UpdateSteamUserId(this.steamUserId);

  @override
  List<Object?> get props => [steamUserId];
}

class UpdateSteamGridDbApiKey extends ConfigEvent {
  final String apiKey;

  const UpdateSteamGridDbApiKey(this.apiKey);

  @override
  List<Object?> get props => [apiKey];
}

class SaveConfig extends ConfigEvent {
  final Config config;

  const SaveConfig(this.config);

  @override
  List<Object?> get props => [config];
}
