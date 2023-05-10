import '../../models.dart';

///The model used for patching the alert prefs
class AlertPreference extends UserPreference<List<ActivityType>> {
  ///Creates a new [AlertPreference]
  const AlertPreference({
    required List<ActivityType> value,
  }) : super('alert', value);

  @override
  List<Object?> get props => [
        value,
      ];
}
