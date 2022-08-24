import 'package:flutter_bloc/flutter_bloc.dart';

import '../abstracts/repositories/base_repository.dart';
import 'games_state.dart';

/// A cubit that keeps the list of games.
class GamesCubit extends Cubit<GamesState> {
  final BaseRepository _repository;

  /// Maximum number of games to load at a time.
  final int limit;

  /// Creates a new cubit using the supplied `repository`
  GamesCubit({
    required BaseRepository repository,
    String? customerID,
    this.limit = 10,
  })  : _repository = repository,
        super(GamesState());

  /// Loads a list of games, optionally using.
  ///
  /// If [loadMore] is true, will try to update the list with more data.
  Future<void> load({
    bool loadMore = false,
  }) async {
    emit(
      state.copyWith(
        busy: true,
        errorStatus: GamesErrorStatus.none,
      ),
    );

    final offset = loadMore ? state.offset + limit : 0;

    try {
      final games = await _repository.getPopularGames(
        limit: limit,
        offset: offset,
      );

      if (games.isNotEmpty) {
        final coverIds = games
            .where((game) => game.cover != null)
            .map((game) => game.cover!.id)
            .toList();
        final covers = await _repository.getCovers(coverIds);

        for (var game in games) {
          if (game.cover != null) {
            game.cover =
                covers.firstWhere((cover) => cover.id == game.cover!.id);
          }
        }
      }

      final list = offset > 0 ? [...state.games, ...games] : games;

      emit(
        state.copyWith(
          games: list,
          busy: false,
          offset: offset,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          busy: false,
          errorStatus: GamesErrorStatus.generic,
        ),
      );
    }
  }
}
