import '../../domain_layer/model/game.dart';
import '../dto/game_dto.dart';

/// Extension that provides mappings for [GameDTO]
extension GameDTOMapping on GameDTO {
  /// Maps into a [Game]
  Game toGame() => Game(
        name: name,
        cover: cover,
        rating: rating ?? 0.0,
      );
}
