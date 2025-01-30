
import 'package:equatable/equatable.dart';

import '../../../Home/data/model/product_model.dart';

abstract class FavoritesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoritesInitialState extends FavoritesState {}

class FavoritesLoadingState extends FavoritesState {}

class FavoritesSuccessState extends FavoritesState {
  final List<ProductModel> favorites;
  FavoritesSuccessState(this.favorites);
}

class FavoritesFailureState extends FavoritesState {
  final String errorMessage;
  FavoritesFailureState(this.errorMessage);
}
