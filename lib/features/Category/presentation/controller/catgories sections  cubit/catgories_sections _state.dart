part of 'catgories_sections _cubit.dart';

@immutable
sealed class CatgoriesSectionsState {}

final class CatgoriesSectionsInitial extends CatgoriesSectionsState {}
class CategoriesLoadingState extends CatgoriesSectionsState { }
class CategoriesFailureState extends CatgoriesSectionsState {
  final String errorMessage ;
  CategoriesFailureState({required this.errorMessage}) ;
}
class CategoriesSuccessState extends CatgoriesSectionsState { }
