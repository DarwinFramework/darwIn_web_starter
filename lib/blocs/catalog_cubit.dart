import 'package:bloc/bloc.dart';
import 'package:darwin_starter/darwin_starter.dart';
import 'package:meta/meta.dart';

part 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {

  CatalogCubit() : super(CatalogInitial());

  Future load() async {
    emit(CatalogLoading());
    var dependables = await StarterCatalog.getDependables();
    emit(CatalogLoaded(dependables));
  }
}
