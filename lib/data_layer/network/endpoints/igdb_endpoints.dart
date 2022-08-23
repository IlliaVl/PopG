import '../../../domain_layer/abstracts/network/endpoints/base_endpoints.dart';

/// IGDB endpoints
class IgdbEndpoints extends BaseEndpoints {
  /// Creates new [IgdbEndpoints]
  const IgdbEndpoints();

  /// Games endpoint
  @override
  String get games => 'games';

  /// Covers endpoint
  @override
  String get covers => 'covers';
}
