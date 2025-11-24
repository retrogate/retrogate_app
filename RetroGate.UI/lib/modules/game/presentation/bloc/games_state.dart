import 'package:equatable/equatable.dart';
import '../../domain/models/game.dart';

abstract class GamesState extends Equatable {
  const GamesState();

  @override
  List<Object?> get props => [];
}

class GamesInitialState extends GamesState {
  const GamesInitialState();
}

class GamesLoadingState extends GamesState {
  const GamesLoadingState();
}

class GamesLoadedState extends GamesState {
  final List<Game> games;

  const GamesLoadedState(this.games);

  @override
  List<Object?> get props => [games];
}

class GamesEmptyState extends GamesState {
  const GamesEmptyState();
}

class GamesErrorState extends GamesState {
  final String message;

  const GamesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
