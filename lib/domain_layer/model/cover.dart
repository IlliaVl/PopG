/// Data transfer object that represents a cover.
class Cover {
  /// Image id of the cover
  final String imageUrlString;

  /// Cover width
  final int width;

  /// Cover height
  final int height;

  /// Creates new [Cover]
  Cover({
    required this.imageUrlString,
    this.width = 0,
    this.height = 0,
  });
}
