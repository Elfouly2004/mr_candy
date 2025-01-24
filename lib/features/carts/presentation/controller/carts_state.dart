import '../../data/model/cart_model.dart';

abstract class CartsState {}

class CartsInitialState extends CartsState {}

class CartsLoadingState extends CartsState {}

class CartsSuccessState extends CartsState {
  final List<CartItemModel> cartsList;

  CartsSuccessState(this.cartsList);
}

class CartsFailureState extends CartsState {
  final String errorMessage;
  CartsFailureState(this.errorMessage);
}
