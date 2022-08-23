import '../../../data_layer/dto/cover_dto.dart';
import '../../../data_layer/dto/game_dto.dart';
import '../network/net_client.dart';

/// An abstract provider for all data
abstract class BaseProvider {
  /// The NetClient to use for the network requests
  final NetClient netClient;

  /// Creates a new [BaseProvider] with the supplied [netClient]
  BaseProvider(this.netClient);

  /// Returns list of popular games DTOs
  Future<List<GameDTO>> getPopularGames();

  /// Returns list of covers DTOs for provided list of [ids]
  Future<List<CoverDTO>> getCovers(List<int> ids);
}