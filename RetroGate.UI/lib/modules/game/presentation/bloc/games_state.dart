import 'package:equatable/equatable.dart';
import '../../domain/models/game.dart';
import '../../domain/models/game_images.dart';
import '../../domain/models/game_source.dart';

abstract class GamesState extends Equatable {
  const GamesState();

  @override
  List<Object?> get props => [];
}

class GamesInitialState extends GamesState {
  const GamesInitialState();
}

class GamesLoadingState extends GamesState {
  final GameSource? source; // Which source is being loaded

  const GamesLoadingState([this.source]);

  @override
  List<Object?> get props => [source];
}

// New unified state that holds games for all sources
class GamesDataState extends GamesState {
  final Map<GameSource, List<Game>> games;

  const GamesDataState(this.games);

  // final Map<GameSource, List<Game>> gamesMap;
  // final GameSource? lastLoadedSource;

  // const GamesDataState(this.gamesMap, [this.lastLoadedSource]);

  // List<Game> getGames(GameSource source) => gamesMap[source] ?? [];
  // bool isEmpty(GameSource source) => getGames(source).isEmpty;
  // bool hasData(GameSource source) => gamesMap.containsKey(source);

  // @override
  // List<Object?> get props => [gamesMap, lastLoadedSource];

  // GamesDataState copyWith({
  //   Map<GameSource, List<Game>>? gamesMap,
  //   GameSource? lastLoadedSource,
  // }) {
  //   return GamesDataState(
  //     gamesMap ?? this.gamesMap,
  //     lastLoadedSource ?? this.lastLoadedSource,
  //   );
  // }
}

class GamesErrorState extends GamesState {
  final String message;

  const GamesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class GameCreatingState extends GamesState {
  const GameCreatingState();
}

class GameCreatedState extends GamesState {
  final Game game;

  const GameCreatedState(this.game);

  @override
  List<Object?> get props => [game];
}

class GameImagesLoadingState extends GamesState {
  const GameImagesLoadingState();
}

class GameImagesLoadedState extends GamesState {
  final GameImages images;

  const GameImagesLoadedState(this.images);

  @override
  List<Object?> get props => [images];
}
