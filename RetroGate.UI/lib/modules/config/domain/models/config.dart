import 'package:equatable/equatable.dart';

class Config extends Equatable {
  final String steamPath;
  final String steamUserId;
  final String steamGridDbApiKey;
  final String installedGamesPath;

  const Config({
    required this.steamPath,
    required this.steamUserId,
    required this.steamGridDbApiKey,
    required this.installedGamesPath,
  });

  Config copyWith({
    String? steamPath,
    String? steamUserId,
    String? steamGridDbApiKey,
    String? installedGamesPath,
  }) {
    return Config(
      steamPath: steamPath ?? this.steamPath,
      steamUserId: steamUserId ?? this.steamUserId,
      steamGridDbApiKey: steamGridDbApiKey ?? this.steamGridDbApiKey,
      installedGamesPath: installedGamesPath ?? this.installedGamesPath,
    );
  }

  @override
  List<Object?> get props => [steamPath, steamUserId, steamGridDbApiKey, installedGamesPath];
}
