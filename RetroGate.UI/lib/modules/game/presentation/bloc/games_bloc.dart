import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_all_games_usecase.dart';
import 'games_event.dart';
import 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GetAllGamesUseCase getAllGamesUseCase;

  GamesBloc({required this.getAllGamesUseCase}) : super(const GamesInitialState()) {
    on<LoadGamesEvent>(_onLoadGames);
    on<RefreshGamesEvent>(_onRefreshGames);
  }

  Future<void> _onLoadGames(LoadGamesEvent event, Emitter<GamesState> emit) async {
    emit(const GamesLoadingState());
    await _fetchGames(emit);
  }

  Future<void> _onRefreshGames(RefreshGamesEvent event, Emitter<GamesState> emit) async {
    emit(const GamesLoadingState());
    await _fetchGames(emit);
  }

  Future<void> _fetchGames(Emitter<GamesState> emit) async {
    final result = await getAllGamesUseCase();

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
