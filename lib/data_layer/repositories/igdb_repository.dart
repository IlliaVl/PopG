import 'package:popg/data_layer/mapping/cover_dto_mapping.dart';
import 'package:popg/data_layer/mapping/game_dto_mapping.dart';
import 'package:popg/domain_layer/abstracts/repositories/base_repository.dart';
import 'package:popg/domain_layer/model/cover.dart';
import 'package:popg/domain_layer/model/game.dart';

import '../providers/igdb_provider.dart';

class IgdbRepository extends BaseRepository {
  final IgdbProvider _provider;

  /// Creates new [IgdbRepository]
  IgdbRepository({required IgdbProvider provider}) : _provider = provider;

  /// Returns list of popular games
  ///
  /// Use `limit` and `offset` to paginate.
  @override
  Future<List<Game>> getPopularGames({
    int limit = 30,
    int offset = 0,
  }) async {
    final dtos = await _provider.getPopularGames(
      limit: limit,
      offset: offset,
    );
    return dtos.map((dameDto) => dameDto.toGame()).toList();
  }

  /// Returns list of covers for provided list of [ids]
  @override
  Future<List<Cover>> getCovers(List<int> ids) async {
    final dtos = await _provider.getCovers(ids);
    return dtos
        .map((coverDto) => coverDto.toCover(_coverImageBuilder))
        .toList();
  }

  /// Getting cover image url path for provided [imageId]
  String _coverImageBuilder(String imageId) =>
      'https://images.igdb.com/igdb/image/upload/t_cover_big_2x/$imageId.jpg';
}
