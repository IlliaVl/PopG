import 'package:dio/dio.dart';

import 'endpoints/base_endpoints.dart';

/// Handles all communication with the backend
abstract class NetClient {
  /// The HTTP client.
  final Dio _client;

  /// Endpoint paths to be used by this [NetClient]
  final BaseEndpoints endpoints;

  /// Getting cover image url path for provided [imageId]
  String getCoverPath(String imageId);

  /// Creates new [NetClient] with provided [baseUrl]
  /// and optional [defaultHeaders]
  NetClient({
    required this.endpoints,
    required String baseUrl,
    Map<String, dynamic>? defaultHeaders,
  }) : _client = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: defaultHeaders,
          ),
        );

  /// Calls request to [path] with the request data
  Future<Response> call(
    String path, {
    data,
  }) async {
    try {
      final response = await _client.post(
        path,
        data: data,
      );

      return response;
    } on DioError catch (e) {
      print('Error: ${e.message}');
      rethrow;
    }
  }
}
