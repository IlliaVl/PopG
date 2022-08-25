import 'package:flutter/material.dart';

import '../../domain_layer/model/game.dart';
import '../widgets/constrained_network_image.dart';

/// Screen for displaying details of the game object
class GameDetailsScreen extends StatelessWidget {
  /// Selected game
  final Game game;

  /// Creates new [GameDetailsScreen].
  const GameDetailsScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              if (game.cover?.imageUrlString != null)
                ConstrainedNetworkImage(
                  imageUrl: game.cover!.imageUrlString,
                  imageWidth: game.cover!.width,
                  imageHeight: game.cover!.height,
                ),
              const SizedBox(height: 16.0),
              Text(
                'Rating: ${game.rating.toStringAsFixed(2)}',
                textAlign: TextAlign.end,
              ),
              if (game.storyline.isNotEmpty) ...[
                const SizedBox(height: 16.0),
                Text(
                  game.storyline,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              if (game.summary.isNotEmpty) ...[
                const SizedBox(height: 16.0),
                Text(
                  game.summary,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
