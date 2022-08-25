import 'cover.dart';

/// Model representing game data
class Game {
  /// Name of the game
  final String name;

  /// Storyline of the game
  final String storyline;

  /// Summary of the game
  final String summary;

  /// Cover of the game
  Cover? cover;

  /// Rating of the game
  final double rating;

  /// Creates new [Game]
  Game({
    required this.name,
    this.storyline = '',
    this.summary = '',
    this.cover,
    this.rating = 0.0,
  });
}
