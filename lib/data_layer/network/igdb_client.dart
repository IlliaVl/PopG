import 'endpoints/base_endpoints.dart';
import 'endpoints/igdb_endpoints.dart';
import 'net_client.dart';

/// Net client for IGDB
class IgdbClient extends NetClient {
  static const String _baseUrl = 'https://api.igdb.com/v4/';
  static const Map<String, dynamic> _defaultHeaders = {
    'Client-ID': 'u6af748z763fv91nngx1nlohgm3a40',
    'Authorization': 'Bearer rxhv28jk7u8d39l5wn2d0u6slwi7hc'
  };

  /// Creates new [IgdbClient]
  IgdbClient({
    BaseEndpoints endpoints = const IgdbEndpoints(),
  }) : super(
          endpoints: endpoints,
          baseUrl: _baseUrl,
          defaultHeaders: _defaultHeaders,
        );
}
