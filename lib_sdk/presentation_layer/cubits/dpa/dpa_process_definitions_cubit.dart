import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../../data_layer/network.dart';
import '../../../domain_layer/use_cases.dart';
import '../../cubits.dart';
import '../../extensions.dart';

/// A cubit that manages a list of DPA processes definitions available for
/// this user.
class DPAProcessDefinitionsCubit extends Cubit<DPAProcessDefinitionsState> {
  final _log = Logger('DPAProcessDefinitionsCubit');

  final ListProcessDefinitionsUseCase _definitionsUseCase;

  /// Creates a new cubit using the supplied [ListProcessDefinitionsUseCase].
  DPAProcessDefinitionsCubit({
    required ListProcessDefinitionsUseCase definitionsUseCase,
  })  : _definitionsUseCase = definitionsUseCase,
        super(DPAProcessDefinitionsState());

  /// Loads all the tasks available for this user.
  ///
  /// If [forceRefresh] is true, will skip the cache.
  /// Defaults to `false`.
  ///
  /// if [onlyLatestVersions] is true, the only the latest version will be
  /// retrieved.
  /// Defaults to `true`.
  Future<void> load({
    bool forceRefresh = false,
    bool onlyLatestVersions = true,
  }) async {
    _log.info('Load. Forcing refresh? $forceRefresh');

    emit(
      state.copyWith(
        actions: state.addAction(
          DPAProcessDefinitionsAction.tasks,
        ),
        errors: state.removeErrorForAction(
          DPAProcessDefinitionsAction.tasks,
        ),
      ),
    );

    try {
      final definitions = await _definitionsUseCase(
        forceRefresh: forceRefresh,
        onlyLatestVersions: onlyLatestVersions,
      );

      emit(
        state.copyWith(
          actions: state.removeAction(DPAProcessDefinitionsAction.tasks),
          definitions: definitions,
        ),
      );
    } on NetException catch (e, st) {
      logException(e, st);
      emit(
        state.copyWith(
          actions: state.removeAction(DPAProcessDefinitionsAction.tasks),
          errors: state.addErrorFromException(
            action: DPAProcessDefinitionsAction.tasks,
            exception: e,
          ),
        ),
      );
    }
  }
}
