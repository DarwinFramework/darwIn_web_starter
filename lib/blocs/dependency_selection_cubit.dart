import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dependency_selection_state.dart';

class DependencySelectionCubit extends Cubit<DependencySelectionState> {
  DependencySelectionCubit() : super(DependencySelectionState());

  void add(String dependency) {
    var current = state.selected;
    emit(DependencySelectionState(current.toSet()..add(dependency)));
  }

  void remove(String dependency) {
    var current = state.selected;
    emit(DependencySelectionState(current.toSet()..remove(dependency)));
  }

}
