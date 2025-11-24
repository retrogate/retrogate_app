import 'package:equatable/equatable.dart';

class Config extends Equatable {
  final String steamPath;
  final String steamUserId;
  final String steamGridDbApiKey;

  const Config({
    required this.steamPath,
    required this.steamUserId,
    required this.steamGridDbApiKey,
  });

  Config copyWith({
    String? steamPath,
    String? steamUserId,
    String? steamGridDbApiKey,
  }) {
    return Config(
      steamPath: steamPath ?? this.steamPath,
      steamUserId: steamUserId ?? this.steamUserId,
      steamGridDbApiKey: steamGridDbApiKey ?? this.steamGridDbApiKey,
    );
  }

  @override
  List<Object?> get props => [steamPath, steamUserId, steamGridDbApiKey];
}
