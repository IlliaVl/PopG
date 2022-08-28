import 'package:popg/data_layer/database/app_database.dart';

import '../../domain_layer/abstracts/providers/base_provider.dart';
import '../dto/cover_dto.dart';
import '../dto/game_dto.dart';

/// IGDB data provider
class IgdbProvider extends BaseProvider with DatabaseHelper {
  /// Creates new [IgdbProvider]
  IgdbProvider(super.netClient);

  /// Returns list of popular games DTOs
  ///
  /// Use `limit` and `offset` to paginate.
  @override
  Future<List<GameDTO>> getPopularGames({
    int limit = 30,
    int offset = 0,
  }) async {
    if (!(await netClient.connected())) {
      return selectPopularGames(
        limit: limit,
        offset: offset,
      );
    }
    final response = await netClient(
      netClient.endpoints.games,
      data: 'fields name, rating, cover, storyline, summary;'
          'sort rating desc;'
          'where rating != null;'
          'limit $limit;'
          'offset $offset;',
    );
    if (response.data is List) {
      final dtos = GameDTO.fromJsonList(
        List<Map<String, dynamic>>.from(response.data),
      );
      saveGames(dtos);
      return dtos;
    }
    throw 'Games were not received';
  }

  /// Returns list of covers DTOs for provided list of [ids]
  @override
  Future<List<CoverDTO>> getCovers(List<int> ids) async {
    if (!(await netClient.connected())) {
      return selectCovers(ids);
    }
    final response = await netClient(
      netClient.endpoints.covers,
      data: 'fields game, image_id, width, height;'
          'limit 100;'
          'where id = (${ids.join(",")});',
    );
    if (response.data is List) {
      final dtos = CoverDTO.fromJsonList(
        List<Map<String, dynamic>>.from(response.data),
      );
      saveCovers(dtos);
      return dtos;
    }
    throw 'Cover was not received';
  }
}
