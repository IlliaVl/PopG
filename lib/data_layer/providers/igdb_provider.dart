import 'package:dio/dio.dart';

import 'base_provider.dart';

/// IGDB data provider
class IgdbProvider extends BaseProvider {
  /// Creates new [IgdbProvider]
  IgdbProvider(super.netClient);

  @override
  Future<Response> getPopularGames() {
    final response = netClient(
      netClient.endpoints.games,
      data: 'fields name, rating, cover, artworks, screenshots;'
          'sort rating desc;'
          'where rating != null;'
          'limit 100;',
    );
    return response;
  }
}
