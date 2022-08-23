/// Data transfer object that represents a game.
class Game {
  /// Name of the game
  final String name;

  /// Cover ID of the game
  final int? cover;

  /// Rating of the game
  final double rating;

  /// Creates new [Game]
  Game({
    required this.name,
    this.cover,
    this.rating = 0.0,
  });
}
