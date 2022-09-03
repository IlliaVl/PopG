import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popg/domain_layer/abstracts/repositories/base_repository.dart';
import 'package:popg/domain_layer/cubits/games_cubit.dart';
import 'package:popg/domain_layer/cubits/games_state.dart';
import 'package:popg/domain_layer/model/cover.dart';
import 'package:popg/domain_layer/model/game.dart';

class MockGamesRepository extends Mock implements BaseRepository {}

void main() {
  const limit = 10;
  const gamesLength = 99;

  final games = List.generate(
    gamesLength,
    (index) => Game(
      id: index,
      name: 'game_$index',
      cover: Cover(id: index),
    ),
  );

  final covers = List.generate(
    gamesLength,
    (index) => Cover(id: index),
  );

  final repository = MockGamesRepository();

  late GamesCubit cubit;

  setUp(
    () {
      cubit = GamesCubit(repository: repository);

      when(
        () => repository.getPopularGames(
          limit: limit,
          offset: 0,
        ),
      ).thenAnswer(
        (_) async => games.take(limit).toList(),
      );

      /// Getting games with offset == limit
      when(
        () => repository.getPopularGames(
          limit: limit,
          offset: limit,
        ),
      ).thenAnswer(
        (_) async => games.skip(limit).take(limit).toList(),
      );

      when(
        () => repository.getCovers(
          games.take(limit).map((game) => game.cover!.id).toList(),
        ),
      ).thenAnswer(
        (_) async => covers.take(limit).toList(),
      );

      /// Getting covers with offset == limit
      when(
        () => repository.getCovers(
          games.skip(limit).take(limit).map((game) => game.cover!.id).toList(),
        ),
      ).thenAnswer(
        (_) async => covers.skip(limit).take(limit).toList(),
      );
    },
  );

  blocTest<GamesCubit, GamesState>(
    'Starts with empty state',
    build: () => cubit,
    verify: (c) => expect(
      c.state,
      GamesState(),
    ),
  );

  blocTest<GamesCubit, GamesState>(
    'Loads games, '
    'emits state with loaded games',
    build: () => cubit,
    act: (c) => c.load(),
    expect: () => [
      GamesState(busy: true),
      GamesState(
        games: games.take(limit),
        busy: false,
        offset: 0,
      )
    ],
    verify: (c) {
      verify(
        () => repository.getPopularGames(
          limit: limit,
        ),
      ).called(1);
      verify(
        () => repository.getCovers(
          games.take(limit).map((game) => game.cover!.id).toList(),
        ),
      ).called(1);
    },
  );

  blocTest<GamesCubit, GamesState>(
    'Loads games with offset, '
    'emits state with loaded games',
    build: () => cubit,
    seed: () => GamesState(
      games: games.take(limit),
    ),
    act: (c) => c.load(loadMore: true),
    expect: () => [
      GamesState(
        busy: true,
        games: games.take(limit),
      ),
      GamesState(
        games: games.take(2 * limit),
        busy: false,
        offset: limit,
      )
    ],
    verify: (c) {
      verify(
        () => repository.getPopularGames(
          limit: limit,
          offset: limit,
        ),
      ).called(1);
      verify(
        () => repository.getCovers(
          games.skip(limit).take(limit).map((game) => game.cover!.id).toList(),
        ),
      ).called(1);
    },
  );

  blocTest<GamesCubit, GamesState>(
    'Handles exceptions gracefully',
    setUp: () {
      /// Test case that throws Exception
      when(
        () => repository.getPopularGames(limit: limit),
      ).thenAnswer(
        (_) async => throw Exception('Some Error'),
      );
    },
    build: () => cubit,
    act: (c) => c.load(),
    expect: () => [
      GamesState(busy: true),
      GamesState(
        busy: false,
        errorStatus: GamesErrorStatus.generic,
      )
    ],
    verify: (c) {
      verify(
        () => repository.getPopularGames(limit: limit),
      ).called(1);
    },
  );
}
