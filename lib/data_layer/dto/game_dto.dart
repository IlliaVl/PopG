/// Data transfer object that represents a game.
class GameDTO {
  /// ID of the game
  final int id;

  /// Name of the game
  final String name;

  /// Cover ID of the game
  final int? cover;

  /// Rating of the game
  final double? rating;

  /// Creates new [GameDTO]
  GameDTO({
    required this.id,
    required this.name,
    this.cover,
    this.rating,
  });

  /// Creates a [GameDTO] from a json.
  factory GameDTO.fromJson(Map<String, dynamic> json) => GameDTO(
        id: json['id'],
        cover: json['cover'],
        name: json['name'],
        rating: json['rating'],
      );

  /// Creates a [GameDTO]s from a list of json maps.
  static List<GameDTO> fromJsonList(List<Map<String, dynamic>> json) =>
      json.map(GameDTO.fromJson).toList();
}
