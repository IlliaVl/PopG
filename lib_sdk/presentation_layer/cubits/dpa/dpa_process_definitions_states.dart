import 'dart:collection';

import '../../../domain_layer/models.dart';
import '../../cubits.dart';

/// The available busy actions that the cubit can perform.
enum DPAProcessDefinitionsAction {
  /// Loading the tasks.
  tasks,
}

/// The state that holds the DPA process definitions.
class DPAProcessDefinitionsState
    extends BaseState<DPAProcessDefinitionsAction, void, void> {
  /// The list of processes available.
  final UnmodifiableListView<DPAProcessDefinition> definitions;

  /// Creates a new [DPAProcessDefinitionsState].
  DPAProcessDefinitionsState({
    Iterable<DPAProcessDefinition> definitions = const <DPAProcessDefinition>[],
    super.actions = const <DPAProcessDefinitionsAction>{},
    super.errors = const <CubitError>{},
  }) : definitions = UnmodifiableListView(definitions);

  @override
  List<Object?> get props => [
        errors,
        actions,
        events,
        definitions,
      ];

  /// Creates a [DPAProcessDefinitionsState] based on this one.
  @override
  DPAProcessDefinitionsState copyWith({
    Set<DPAProcessDefinitionsAction>? actions,
    Set<CubitError>? errors,
    Iterable<DPAProcessDefinition>? definitions,
    // DPAProcessDefinitionsErrorStatus? errorStatus,
  }) =>
      DPAProcessDefinitionsState(
        actions: actions ?? super.actions,
        errors: errors ?? super.errors,
        definitions: definitions ?? this.definitions,
      );
}
