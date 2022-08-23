import '../../domain_layer/abstracts/providers/base_provider.dart';
import '../dto/cover_dto.dart';
import '../dto/game_dto.dart';

/// IGDB data provider
class IgdbProvider extends BaseProvider {
  /// Creates new [IgdbProvider]
  IgdbProvider(super.netClient);

  /// Returns list of popular games DTOs
  @override
  Future<List<GameDTO>> getPopularGames() async {
    final response = await netClient(
      netClient.endpoints.games,
      data: 'fields name, rating, cover, artworks, screenshots;'
          'sort rating desc;'
          'where rating != null;'
          'limit 100;',
    );
    if (response.data is List && response.data.length > 0) {
      return GameDTO.fromJsonList(
        List<Map<String, dynamic>>.from(response.data),
      );
    }
    throw 'Games were not received';
  }

  /// Returns list of covers DTOs for provided list of [ids]
  @override
  Future<List<CoverDTO>> getCovers(List<int> ids) async {
    final response = await netClient(
      netClient.endpoints.covers,
      data: 'fields image_id, width, height;'
          'limit 100;'
          'where id = (${ids.join(",")});',
    );
    if (response.data is List && response.data.length > 0) {
      return CoverDTO.fromJsonList(
        List<Map<String, dynamic>>.from(response.data),
      );
    }
    throw 'Cover was not received';
  }
}
