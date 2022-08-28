import 'package:popg/domain_layer/model/cover.dart';

import '../../domain_layer/model/game.dart';
import '../dto/game_dto.dart';

/// Extension that provides mappings for [GameDTO]
extension GameDTOMapping on GameDTO {
  /// Maps into a [Game]
  Game toGame() => Game(
        id: id,
        name: name,
        storyline: storyline ?? '',
        summary: summary ?? '',
        cover: cover == null ? null : Cover(id: cover!),
        rating: rating ?? 0.0,
      );
}
