import 'package:floor/floor.dart';

import '../dto/cover_dto.dart';

@dao
abstract class CoverDTODao {
  @Query('SELECT * FROM CoverDTO WHERE id = :id')
  Stream<CoverDTO?> findCoverDTOById(int id);

  @Query('SELECT * FROM CoverDTO WHERE id IN (:ids)')
  Future<List<CoverDTO>> getCovers(List<int> ids);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertCoverDTO(CoverDTO coverDTO);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertCoverDTOs(List<CoverDTO> coverDTOs);
}
