part of 'settings_cubit.dart';

@immutable
class SettingsState {

  String name;
  ProjectType type;

//<editor-fold desc="Data Methods">

  SettingsState({
    required this.name,
    required this.type,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsState &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type);

  @override
  int get hashCode => name.hashCode ^ type.hashCode;

  @override
  String toString() {
    return 'SettingsState{' + ' name: $name,' + ' type: $type,' + '}';
  }

  SettingsState copyWith({
    String? name,
    ProjectType? type,
  }) {
    return SettingsState(
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'type': this.type,
    };
  }

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      name: map['name'] as String,
      type: map['type'] as ProjectType,
    );
  }

//</editor-fold>
}
