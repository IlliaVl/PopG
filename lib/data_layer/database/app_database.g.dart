// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  GameDTODao? _gameDTODaoInstance;

  CoverDTODao? _coverDTODaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `GameDTO` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `storyline` TEXT, `summary` TEXT, `cover` INTEGER, `rating` REAL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CoverDTO` (`id` INTEGER NOT NULL, `game` INTEGER NOT NULL, `imageId` TEXT NOT NULL, `width` INTEGER, `height` INTEGER, FOREIGN KEY (`game`) REFERENCES `GameDTO` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  GameDTODao get gameDTODao {
    return _gameDTODaoInstance ??= _$GameDTODao(database, changeListener);
  }

  @override
  CoverDTODao get coverDTODao {
    return _coverDTODaoInstance ??= _$CoverDTODao(database, changeListener);
  }
}

class _$GameDTODao extends GameDTODao {
  _$GameDTODao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _gameDTOInsertionAdapter = InsertionAdapter(
            database,
            'GameDTO',
            (GameDTO item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'storyline': item.storyline,
                  'summary': item.summary,
                  'cover': item.cover,
                  'rating': item.rating
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GameDTO> _gameDTOInsertionAdapter;

  @override
  Future<List<GameDTO>> getPopularGames({
    int limit = 30,
    int offset = 0,
  }) async {
    return _queryAdapter.queryList(
        'SELECT * FROM GameDTO ORDER BY rating DESC LIMIT ?2,?1',
        mapper: (Map<String, Object?> row) => GameDTO(
            id: row['id'] as int,
            name: row['name'] as String,
            storyline: row['storyline'] as String?,
            summary: row['summary'] as String?,
            cover: row['cover'] as int?,
            rating: row['rating'] as double?),
        arguments: [limit, offset]);
  }

  @override
  Future<void> insertGameDTO(GameDTO gameDTO) async {
    await _gameDTOInsertionAdapter.insert(gameDTO, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertGameDTOs(List<GameDTO> gameDTOs) async {
    await _gameDTOInsertionAdapter.insertList(
        gameDTOs, OnConflictStrategy.abort);
  }
}

class _$CoverDTODao extends CoverDTODao {
  _$CoverDTODao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _coverDTOInsertionAdapter = InsertionAdapter(
            database,
            'CoverDTO',
            (CoverDTO item) => <String, Object?>{
                  'id': item.id,
                  'game': item.game,
                  'imageId': item.imageId,
                  'width': item.width,
                  'height': item.height
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CoverDTO> _coverDTOInsertionAdapter;

  @override
  Stream<CoverDTO?> findCoverDTOById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM CoverDTO WHERE id = ?1',
        mapper: (Map<String, Object?> row) => CoverDTO(
            id: row['id'] as int,
            game: row['game'] as int,
            imageId: row['imageId'] as String,
            width: row['width'] as int?,
            height: row['height'] as int?),
        arguments: [id],
        queryableName: 'CoverDTO',
        isView: false);
  }

  @override
  Future<List<CoverDTO>> getCovers(List<int> ids) async {
    const offset = 1;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'SELECT * FROM CoverDTO WHERE id IN (' + _sqliteVariablesForIds + ')',
        mapper: (Map<String, Object?> row) => CoverDTO(
            id: row['id'] as int,
            game: row['game'] as int,
            imageId: row['imageId'] as String,
            width: row['width'] as int?,
            height: row['height'] as int?),
        arguments: [...ids]);
  }

  @override
  Future<void> insertCoverDTO(CoverDTO coverDTO) async {
    await _coverDTOInsertionAdapter.insert(coverDTO, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertCoverDTOs(List<CoverDTO> coverDTOs) async {
    await _coverDTOInsertionAdapter.insertList(
        coverDTOs, OnConflictStrategy.abort);
  }
}
