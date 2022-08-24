import '../../domain_layer/model/cover.dart';
import '../dto/cover_dto.dart';

/// Extension that provides mappings for [CoverDTO]
extension CoverDTOMapping on CoverDTO {
  /// Maps into a [Cover]
  Cover toCover(String Function(String) coverImageBuilder) => Cover(
        id: id,
        imageUrlString: coverImageBuilder(imageId),
        width: width ?? 0,
        height: height ?? 0,
      );
}
