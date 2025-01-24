
abstract class CategoriesState{ }
class CategoriesInitialState extends CategoriesState { }
class CategoriesLoadingState extends CategoriesState { }
class CategoriesFailureState extends CategoriesState {
  final String errorMessage ;
  CategoriesFailureState({required this.errorMessage}) ;
}
class CategoriesSuccessState extends CategoriesState { }