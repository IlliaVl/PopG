import '../../../domain_layer/use_cases.dart';
import '../../cubits.dart';
import '../../widgets.dart';

/// Creator responsible for creating [BiometricsCubit].
class BiometricsCreator extends CubitCreator {
  final GetBiometricsEnabledUseCase _getBiometricsEnabledUseCase;

  /// Creates a new [BiometricsCreator] instance.
  BiometricsCreator({
    required GetBiometricsEnabledUseCase getBiometricsEnabledUseCase,
  }) : _getBiometricsEnabledUseCase = getBiometricsEnabledUseCase;

  /// Creates and returns an instance of the [BiometricsCubit].
  BiometricsCubit create() => BiometricsCubit(
        getBiometricsEnabledUseCase: _getBiometricsEnabledUseCase,
      );
}
