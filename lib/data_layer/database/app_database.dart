import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/cover_dao.dart';
import '../dao/game_dao.dart';
import '../dto/cover_dto.dart';
import '../dto/game_dto.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [GameDTO, CoverDTO])
abstract class AppDatabase extends FloorDatabase {
  GameDTODao get gameDTODao;

  CoverDTODao get coverDTODao;
}

/// Helper class to manage database
abstract class DatabaseHelper {
  /// Name of the database
  static const _name = 'app_database.db';

  Future<AppDatabase> get _database async =>
      await $FloorAppDatabase.databaseBuilder(_name).build();

  Future<void> saveGames(List<GameDTO> dtos) async =>
      (await _database).gameDTODao.insertGameDTOs(dtos);

  Future<void> saveCovers(List<CoverDTO> dtos) async =>
      (await _database).coverDTODao.insertCoverDTOs(dtos);

  Future<List<GameDTO>> selectPopularGames({
    int limit = 30,
    int offset = 0,
  }) async =>
      (await _database).gameDTODao.getPopularGames(
            limit: limit,
            offset: offset,
          );

  Future<List<CoverDTO>> selectCovers(List<int> ids) async =>
      (await _database).coverDTODao.getCovers(ids);
}
