import '../../model/cover.dart';
import '../../model/game.dart';

/// The abstract repository.
abstract class BaseRepository {
  /// Creates new [BaseRepository]
  BaseRepository();

  /// Returns list of popular games
  ///
  /// Use `limit` and `offset` to paginate.
  Future<List<Game>> getPopularGames({
    int limit = 30,
    int offset = 0,
  });

  /// Returns list of covers for provided list of [ids]
  Future<List<Cover>> getCovers(List<int> ids);
}
