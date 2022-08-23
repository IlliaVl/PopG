import 'package:popg/data_layer/mapping/cover_dto_mapping.dart';
import 'package:popg/data_layer/mapping/game_dto_mapping.dart';
import 'package:popg/domain_layer/abstracts/repositories/base_repository.dart';
import 'package:popg/domain_layer/model/cover.dart';
import 'package:popg/domain_layer/model/game.dart';

class IgdbRepository extends BaseRepository {
  /// Creates new [IgdbRepository]
  IgdbRepository({required super.provider});

  /// Returns list of popular games
  @override
  Future<List<Game>> getPopularGames() async {
    final dtos = await provider.getPopularGames();
    return dtos.map((dameDto) => dameDto.toGame()).toList();
  }

  /// Returns list of covers for provided list of [ids]
  @override
  Future<List<Cover>> getCovers(List<int> ids) async {
    final dtos = await provider.getCovers(ids);
    return dtos.map((coverDto) => coverDto.toCover()).toList();
  }
}
