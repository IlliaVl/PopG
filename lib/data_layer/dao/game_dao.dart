import 'package:floor/floor.dart';

import '../dto/game_dto.dart';

@dao
abstract class GameDTODao {
  @Query('SELECT * FROM GameDTO ORDER BY rating DESC LIMIT :offset,:limit')
  Future<List<GameDTO>> getPopularGames({
    int limit = 30,
    int offset = 0,
  });

  @insert
  Future<void> insertGameDTO(GameDTO gameDTO);

  @insert
  Future<void> insertGameDTOs(List<GameDTO> gameDTOs);
}
