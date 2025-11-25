import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrogate_ui/modules/game/domain/models/game_source.dart';
import '../../domain/usecases/get_all_games_usecase.dart';
import '../../domain/usecases/create_game_usecase.dart';
import '../../domain/usecases/get_game_images_usecase.dart';
import 'games_event.dart';
import 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GetAllGamesUseCase getAllGamesUseCase;
  final CreateGameUseCase createGameUseCase;
  final GetGameImagesUseCase getGameImagesUseCase;

  GamesBloc({
    required this.getAllGamesUseCase,
    required this.createGameUseCase,
    required this.getGameImagesUseCase,
  }) : super(const GamesInitialState()) {
    on<LoadGamesEvent>(_onLoadGames);
    on<RefreshGamesEvent>(_onRefreshGames);
    on<CreateGameEvent>(_onCreateGame);
    on<LoadGameImagesEvent>(_onLoadGameImages);
  }

  Future<void> _onLoadGames(LoadGamesEvent event, Emitter<GamesState> emit) async {
    emit(const GamesLoadingState());
    await _fetchGames(emit);
  }

  Future<void> _onRefreshGames(RefreshGamesEvent event, Emitter<GamesState> emit) async {
    emit(const GamesLoadingState());
    await _fetchGames(emit);
  }

  Future<void> _onCreateGame(CreateGameEvent event, Emitter<GamesState> emit) async {
    emit(const GameCreatingState());

    final result = await createGameUseCase(GameSource.available, event.game);

    result.fold(
      (error) {
        emit(GamesErrorState(error.toString()));
      },
      (createdGame) {
        emit(GameCreatedState(createdGame));
        // Reload games list after creating
        add(const LoadGamesEvent());
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

  Future<void> _fetchGames(Emitter<GamesState> emit) async {
    final result = await getAllGamesUseCase(GameSource.available);

    result.fold(
      (error) {
        emit(GamesErrorState(error.toString()));
      },
      (games) {
        if (games.isEmpty) {
          emit(const GamesEmptyState());
        } else {
          emit(GamesLoadedState(games));
        }
      },
    );
  }
}
