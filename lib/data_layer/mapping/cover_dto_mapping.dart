import '../../domain_layer/model/cover.dart';
import '../dto/cover_dto.dart';

/// Extension that provides mappings for [CoverDTO]
extension CoverDTOMapping on CoverDTO {
  /// Maps into a [Cover]
  Cover toCover() => Cover(
        imageUrlString: '',
        width: width ?? 0,
        height: height ?? 0,
      );
}
