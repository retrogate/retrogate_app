import 'package:equatable/equatable.dart';
import '../../domain/models/game.dart';
import '../../domain/models/game_source.dart';

abstract class GamesEvent extends Equatable {
  const GamesEvent();

  @override
  List<Object?> get props => [];
}

class LoadGamesEvent extends GamesEvent {
  final GameSource source;
  
  const LoadGamesEvent(this.source);
  
  @override
  List<Object?> get props => [source];
}

class RefreshGamesEvent extends GamesEvent {
  final GameSource source;
  
  const RefreshGamesEvent(this.source);
  
  @override
  List<Object?> get props => [source];
}

class CreateGameEvent extends GamesEvent {
  final GameSource source;
  final Game game;

  const CreateGameEvent(this.source, this.game);

  @override
  List<Object?> get props => [source, game];
}

class LoadGameImagesEvent extends GamesEvent {
  final String gameName;

  const LoadGameImagesEvent(this.gameName);

  @override
  List<Object?> get props => [gameName];
}

class LaunchGameEvent extends GamesEvent {
  final String gameId;

  const LaunchGameEvent(this.gameId);

  @override
  List<Object?> get props => [gameId];
}