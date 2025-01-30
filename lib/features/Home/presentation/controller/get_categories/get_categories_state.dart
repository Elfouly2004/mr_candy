
import 'package:equatable/equatable.dart';

abstract class CategoriesState extends Equatable{
  @override
  List<Object?> get props => [];
}
class CategoriesInitialState extends CategoriesState { }
class CategoriesLoadingState extends CategoriesState { }
class CategoriesFailureState extends CategoriesState {
  final String errorMessage ;
  CategoriesFailureState({required this.errorMessage}) ;
}
class CategoriesSuccessState extends CategoriesState { }