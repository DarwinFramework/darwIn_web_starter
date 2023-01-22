import 'package:bloc/bloc.dart';
import 'package:darwin_starter/darwin_starter.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState(
      name: "my_app", type: ProjectType.rest
  ));

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void setType(ProjectType type) {
    emit(state.copyWith(type: type));
  }
}
