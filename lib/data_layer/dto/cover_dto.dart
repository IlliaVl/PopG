import 'package:floor/floor.dart';

import 'game_dto.dart';

/// Data transfer object that represents a cover.
@Entity(
  tableName: 'CoverDTO',
  foreignKeys: [
    ForeignKey(
      childColumns: ['game'],
      parentColumns: ['id'],
      entity: GameDTO,
    )
  ],
)
class CoverDTO {
  /// ID of the cover
  @primaryKey
  final int id;

  /// Game ID for which the cover belongs
  final int game;

  /// Image id of the cover
  final String imageId;

  /// Cover width
  final int? width;

  /// Cover height
  final int? height;

  /// Creates new [CoverDTO]
  CoverDTO({
    required this.id,
    required this.game,
    required this.imageId,
    this.width,
    this.height,
  });

  /// Creates a [CoverDTO] from a json.
  factory CoverDTO.fromJson(Map<String, dynamic> json) => CoverDTO(
        id: json['id'],
        game: json['game'],
        imageId: json['image_id'],
        height: json['height'],
        width: json['width'],
      );

  /// Creates a [CoverDTO]s from a list of json maps.
  static List<CoverDTO> fromJsonList(List<Map<String, dynamic>> json) =>
      json.map(CoverDTO.fromJson).toList();
}
