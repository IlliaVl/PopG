import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../data_layer/network.dart';

/// Extension function to help logging exceptions thrown by cubits
extension CubitLogHelper on Cubit {
  /// Logs the exception from the stacktrace
  void logException(Exception e, StackTrace st) {
    final log = Logger('LayerSDK');
    final frames = StackFrame.fromStackTrace(st);
    final frame = frames.isNotEmpty ? frames.first : null;
    final exceptionString =
        e is NetException ? (e.message ?? '') : e.toString();

    log.log(
      Level.SEVERE,
      '${frame?.className} - ${frame?.method} exception: $exceptionString',
    );
  }
}
