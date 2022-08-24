import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popg/data_layer/network/igdb_client.dart';
import 'package:popg/data_layer/providers/igdb_provider.dart';
import 'package:popg/data_layer/repositories/igdb_repository.dart';
import 'package:popg/domain_layer/abstracts/repositories/base_repository.dart';

import 'domain_layer/cubits/games_cubit.dart';
import 'presentation_layer/screens/games_screen.dart';

// void main() async {
//   final netClient = IgdbClient();
//   final provider = IgdbProvider(netClient);
//   final games = await provider.getPopularGames();
//   final coverIds = games
//       .where((gameDto) => gameDto.cover != null)
//       .map((gameDto) => gameDto.cover!)
//       .toList();
//   final covers = await provider.getCovers(coverIds);
//
//   runApp(const MyApp());
// }

void main() {
  runApp(MyApp(
    repository: IgdbRepository(
      provider: IgdbProvider(
        IgdbClient(),
      ),
    ),
  ));
}

/// The application widget
class MyApp extends StatelessWidget {
  /// The repository responsible for getting all the data
  final BaseRepository repository;

  /// Creates the [MyApp]
  const MyApp({
    Key? key,
    required this.repository,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<GamesCubit>(
            create: (context) => GamesCubit(
              repository: repository,
            )..load(),
          ),
        ],
        child: const GamesScreen(),
      ),
    );
  }
}
