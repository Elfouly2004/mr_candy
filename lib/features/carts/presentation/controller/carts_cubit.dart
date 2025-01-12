import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrcandy/features/carts/data/repos/carts_repo_implmentation.dart';

import '../../data/model/cart_model.dart';
import 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  CartsCubit() : super(CartsInitialState());

  final CartsRepoImplmentation cartRepo = CartsRepoImplmentation();
  List<CartItemModel> cartsList = [];

  static CartsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchCarts() async {
    emit(CartsLoadingState());
    final result = await cartRepo.getCarts();

    result.fold(
          (failure) {
        print("Error fetching carts: ${failure.message}");
        emit(CartsFailureState(failure.message));
      },
          (data) {
        cartsList = data;
        emit(CartsSuccessState(cartsList));
      },
    );
  }


  Future<void> addCart(context, int index) async {
    final result = await cartRepo.Add_carts(context: context, index: index);

    result.fold(
          (failure) {
        emit(CartsFailureState( failure.message));
      },
          (updatedProduct) {

        cartsList[index] = updatedProduct;

        // إصدار حالة النجاح مع قائمة جديدة لضمان إعادة البناء
        emit(CartsSuccessState(List.from(cartsList)));
      },
    );
  }





}
