import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain_layer/cubits/games_cubit.dart';
import '../../domain_layer/cubits/games_state.dart';
import '../widgets/game_card.dart';

/// Screen for displaying list of game objects.
/// Depends on [GamesCubit] which state store all the list of fetched objects.
class GamesScreen extends StatefulWidget {
  /// Creates new [GamesScreen].
  const GamesScreen({Key? key}) : super(key: key);

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final cubit = context.read<GamesCubit>();
        if (cubit.state.busy) {
          return;
        }
        cubit.load(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<GamesCubit>();
    final state = cubit.state;
    final shouldRetry = !state.busy &&
        state.errorStatus != GamesErrorStatus.none &&
        state.games.isEmpty;

    return BlocListener<GamesCubit, GamesState>(
      listener: (context, state) {
        if (!state.busy && state.errorStatus != GamesErrorStatus.none) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong. Try later, please.'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Popular games'),
        ),
        body: shouldRetry
            ? Center(
                child: TextButton(
                  onPressed: cubit.load,
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            : RefreshIndicator(
                onRefresh: cubit.load,
                child: ListView(
                  controller: _scrollController,
                  children: [
                    ...cubit.state.games.map((game) => GameCard(game: game)),
                    if (cubit.state.busy)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
