part of 'catgories_deatils_cubit.dart';

@immutable
sealed class CatgoriesDeatilsState {}

final class CatgoriesDeatilsInitial extends CatgoriesDeatilsState {}
class CategoriesLoadingState extends CatgoriesDeatilsState { }
class CategoriesFailureState extends CatgoriesDeatilsState {
  final String errorMessage ;
  CategoriesFailureState({required this.errorMessage}) ;
}
class CategoriesSuccessState extends CatgoriesDeatilsState { }
