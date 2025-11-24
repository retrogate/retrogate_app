import 'package:equatable/equatable.dart';
import '../../domain/models/game.dart';

abstract class GamesEvent extends Equatable {
  const GamesEvent();

  @override
  List<Object?> get props => [];
}

class LoadGamesEvent extends GamesEvent {
  const LoadGamesEvent();
}

class RefreshGamesEvent extends GamesEvent {
  const RefreshGamesEvent();
}

class CreateGameEvent extends GamesEvent {
  final Game game;

  const CreateGameEvent(this.game);

  @override
  List<Object?> get props => [game];
}

class LoadGameImagesEvent extends GamesEvent {
  final String gameName;

  const LoadGameImagesEvent(this.gameName);

  @override
  List<Object?> get props => [gameName];
}
