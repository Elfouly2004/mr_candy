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



  Future<void> deleteCart(context, int index) async {
    emit(CartsLoadingState());

    final result = await cartRepo.DeleteCarts(context: context, index: index);

    result.fold(
          (failure) {
        emit(CartsFailureState(failure.message));
      },
          (_) {
        // حذف العنصر من القائمة
        cartsList.removeAt(index);

        emit(CartsSuccessState(List.from(cartsList)));


        print("deleeeeeeeeted");
      },
    );
  }


}
