part of 'catalog_cubit.dart';

@immutable
abstract class CatalogState {

}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final Map<String, Dependable> dependables;

  CatalogLoaded(this.dependables);
}
