import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../model/game.dart';

/// The state of the [GamesCubit]
class GamesState extends Equatable {
  /// A list of Games
  final UnmodifiableListView<Game> games;

  /// The current error status.
  final GamesErrorStatus errorStatus;

  /// True if the cubit is processing something.
  final bool busy;

  /// The current offset for the loaded list.
  final int offset;

  /// Creates a new [GamesState].
  GamesState({
    Iterable<Game> games = const <Game>[],
    this.errorStatus = GamesErrorStatus.none,
    this.busy = false,
    this.offset = 0,
  }) : games = UnmodifiableListView(games);

  @override
  List<Object?> get props => [
        games,
        errorStatus,
        busy,
        offset,
      ];

  /// Creates a new state based on this one.
  GamesState copyWith({
    List<Game>? games,
    GamesErrorStatus? errorStatus,
    bool? busy,
    int? offset,
  }) =>
      GamesState(
        games: games ?? this.games,
        errorStatus: errorStatus ?? this.errorStatus,
        busy: busy ?? this.busy,
        offset: offset ?? this.offset,
      );
}

/// The available error status
enum GamesErrorStatus {
  /// No errors
  none,

  /// Generic error
  generic,

  /// Network error
  network,
}
