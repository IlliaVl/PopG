import 'package:floor/floor.dart';

/// Data transfer object that represents a game.
@entity
class GameDTO {
  /// ID of the game
  @primaryKey
  final int id;

  /// Name of the game
  final String name;

  /// Storyline of the game
  final String? storyline;

  /// Summary of the game
  final String? summary;

  /// Cover ID of the game
  final int? cover;

  /// Rating of the game
  final double? rating;

  /// Creates new [GameDTO]
  GameDTO({
    required this.id,
    required this.name,
    this.storyline,
    this.summary,
    this.cover,
    this.rating,
  });

  /// Creates a [GameDTO] from a json.
  factory GameDTO.fromJson(Map<String, dynamic> json) => GameDTO(
        id: json['id'],
        name: json['name'],
        cover: json['cover'],
        storyline: json['storyline'],
        summary: json['summary'],
        rating: json['rating'],
      );

  /// Creates a [GameDTO]s from a list of json maps.
  static List<GameDTO> fromJsonList(List<Map<String, dynamic>> json) =>
      json.map(GameDTO.fromJson).toList();
}
