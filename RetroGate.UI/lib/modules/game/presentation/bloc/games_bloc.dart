import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrogate_ui/modules/game/domain/models/game_source.dart';
import 'package:retrogate_ui/modules/game/domain/usecases/launch_game_usecase.dart';
import '../../domain/models/game.dart';
import '../../domain/usecases/get_all_games_usecase.dart';
import '../../domain/usecases/create_game_usecase.dart';
import '../../domain/usecases/get_game_images_usecase.dart';
import 'games_event.dart';
import 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GetAllGamesUseCase getAllGamesUseCase;
  final CreateGameUseCase createGameUseCase;
  final GetGameImagesUseCase getGameImagesUseCase;
  final LaunchGameUseCase launchGameUseCase;

  GamesBloc({
    required this.getAllGamesUseCase,
    required this.createGameUseCase,
    required this.getGameImagesUseCase,
    required this.launchGameUseCase,
  }) : super(const GamesInitialState()) {
    on<LoadGamesEvent>(_onLoadGames);
    on<RefreshGamesEvent>(_onRefreshGames);
    on<CreateGameEvent>(_onCreateGame);
    on<LoadGameImagesEvent>(_onLoadGameImages);
    on<LaunchGameEvent>(_onLaunchGame);
  }

  Future<void> _onLoadGames(LoadGamesEvent event, Emitter<GamesState> emit) async {
    // Get current data state or create new one
    final currentData = state is GamesDataState 
        ? (state as GamesDataState) 
        : const GamesDataState({});
    
    // If we already have data for this source, don't reload
    if (currentData.hasData(event.source)) {
      return;
    }
    
    emit(GamesLoadingState(event.source));
    await _fetchGames(event.source, emit, currentData);
  }

  Future<void> _onRefreshGames(RefreshGamesEvent event, Emitter<GamesState> emit) async {
    final currentData = state is GamesDataState 
        ? (state as GamesDataState) 
        : const GamesDataState({});
    
    emit(GamesLoadingState(event.source));
    await _fetchGames(event.source, emit, currentData);
  }

  Future<void> _onCreateGame(CreateGameEvent event, Emitter<GamesState> emit) async {
    emit(const GameCreatingState());

    final result = await createGameUseCase(event.source, event.game);

    result.fold(
      (error) {
        emit(GamesErrorState(error.toString()));
      },
      (createdGame) {
        emit(GameCreatedState(createdGame));
        // Reload games list after creating
        add(LoadGamesEvent(event.source));
      },
    );
  }

  Future<void> _onLoadGameImages(LoadGameImagesEvent event, Emitter<GamesState> emit) async {
    emit(const GameImagesLoadingState());

    final result = await getGameImagesUseCase(event.gameName);

    result.fold(
      (error) {
        emit(GamesErrorState(error.toString()));
      },
      (images) {
        emit(GameImagesLoadedState(images));
      },
    );
  }

  Future<void> _onLaunchGame(LaunchGameEvent event, Emitter<GamesState> emit) async {
    try {
      await launchGameUseCase(event.gameId);
      // Optionally, you can emit a state indicating the game launch was successful
    } catch (error) {
      emit(GamesErrorState('Failed to launch game: ${error.toString()}'));
    }
  }

  Future<void> _fetchGames(GameSource source, Emitter<GamesState> emit, GamesDataState currentData) async {
    final result = await getAllGamesUseCase(source);

    result.fold(
      (error) {
        emit(GamesErrorState(error.toString()));
      },
      (games) {
        // Update the games map with new data for this source
        final updatedMap = Map<GameSource, List<Game>>.from(currentData.gamesMap);
        updatedMap[source] = games;
        
        emit(GamesDataState(updatedMap, source));
      },
    );
  }
}
