import 'package:flutter/material.dart';

import '../../model/cover.dart';
import '../../model/game.dart';
import '../providers/base_provider.dart';

/// The abstract repository.
abstract class BaseRepository {
  @protected
  final BaseProvider provider;

  /// Creates new [BaseRepository]
  BaseRepository({required this.provider});

  /// Returns list of popular games
  Future<List<Game>> getPopularGames();

  /// Returns list of covers for provided list of [ids]
  Future<List<Cover>> getCovers(List<int> ids);
}
