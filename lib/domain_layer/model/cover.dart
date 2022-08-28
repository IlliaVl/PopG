import 'package:floor/floor.dart';

/// Model which represents cover of the image
@entity
class Cover {
  /// ID of the cover
  @primaryKey
  final int id;

  /// Image url string of the cover
  final String imageUrlString;

  /// Cover width
  final int width;

  /// Cover height
  final int height;

  /// Creates new [Cover]
  Cover({
    required this.id,
    this.imageUrlString = '',
    this.width = 0,
    this.height = 0,
  });

  /// Creates a [Cover] copy with the provided parameters
  Cover copyWith({
    int? id,
    String? imageUrlString,
    int? width,
    int? height,
  }) {
    return Cover(
      id: id ?? this.id,
      imageUrlString: imageUrlString ?? this.imageUrlString,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}
