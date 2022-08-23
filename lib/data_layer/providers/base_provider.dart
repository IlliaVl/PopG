import 'package:dio/dio.dart';

import '../network/net_client.dart';

/// An abstract provider for all data
abstract class BaseProvider {
  /// The NetClient to use for the network requests
  final NetClient netClient;

  /// Creates a new [BaseProvider] with the supplied [netClient]
  BaseProvider(this.netClient);

  /// Returns list of popular games
  Future<Response> getPopularGames();
}
