import 'package:equatable/equatable.dart';

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
