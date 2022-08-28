import 'package:floor/floor.dart';

import '../dto/cover_dto.dart';

@dao
abstract class CoverDTODao {
  @Query('SELECT * FROM CoverDTO WHERE id = :id')
  Stream<CoverDTO?> findCoverDTOById(int id);

  @Query('SELECT * FROM CoverDTO WHERE id IN (:ids)')
  Future<List<CoverDTO>> getCovers(List<int> ids);

  @insert
  Future<void> insertCoverDTO(CoverDTO coverDTO);

  @insert
  Future<void> insertCoverDTOs(List<CoverDTO> coverDTOs);
}
