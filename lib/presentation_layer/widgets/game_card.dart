import 'package:flutter/material.dart';

import '../../domain_layer/model/game.dart';
import 'constrained_network_image.dart';

/// Card for displaying data of provided [game]
class GameCard extends StatelessWidget {
  /// Game
  final Game game;

  /// Creates new [GameCard]
  const GameCard({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.all(8.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Column(
          children: [
            if (game.cover?.imageUrlString != null)
              ConstrainedNetworkImage(
                imageUrl: game.cover!.imageUrlString,
                imageWidth: game.cover!.width,
                imageHeight: game.cover!.height,
              ),
            ListTile(
              title: Center(
                  child: Text(
                game.name,
                textAlign: TextAlign.center,
              )),
              subtitle: Center(
                child: Text(
                  game.rating.toStringAsFixed(2),
                  // style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
