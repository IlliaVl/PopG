/// Interface for storing endpoints
abstract class BaseEndpoints {
  /// Creates new [BaseEndpoints]
  const BaseEndpoints();

  /// Getter for games endpoint
  String get games;

  /// Getter for covers endpoint
  String get covers;
}
