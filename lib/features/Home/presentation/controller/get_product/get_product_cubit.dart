import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrcandy/features/Home/data/model/categories_model.dart';
import 'package:mrcandy/features/carts/data/model/cart_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/repo/home_repo_implemetation.dart';
import 'get_product_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitialState());

  final HomeRepoImplementation homeRepo = HomeRepoImplementation();

  // قائمة المنتجات التي سيتم تعبئتها بالبيانات بعد جلبها
  List<ProductModel> productList = [];
  List<CartItemModel> cartsList = [];


  // int index1 =0;
  //  Map<int,List<ProductModel>> map_forproducts={};


  static ProductsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchproducts() async {
    emit(ProductsLoadingState());

    final result = await homeRepo.get_product();
    result.fold((failure) {
      print("Error fetching products: ${failure.message}");
      emit(ProductsFailureState(errorMessage: failure.message));
    }, (right) {
      productList = right;
      // map_forproducts.addAll({
      //   index1:productList
      // });
      print("Fetched products: $productList");  // Debug output
      emit(ProductsSuccessState(productList));
    });
  }


  Future<void> addFavorite(context, int index) async {
    final result = await homeRepo.Addfav(context: context, index: index);

    result.fold(
          (failure) {
        print("Error adding to favorites: ${failure.message}");
        emit(ProductsFailureState(errorMessage: failure.message));
      },
          (updatedProduct) {
        print("Product added to favorites: $updatedProduct");

        // تحديث المنتج في القائمة المحلية
        productList[index] = updatedProduct;

        // إصدار حالة النجاح مع قائمة جديدة لضمان إعادة البناء
        emit(ProductsSuccessState(List.from(productList)));
      },
    );
  }



  Future<void> addCart(context, int index) async {
    final result = await homeRepo.Add_carts(context: context, index: index);

    result.fold(
          (failure) {
            emit(ProductsFailureState(errorMessage: failure.message));
      },
          (updatedProduct) {

        cartsList[index] = updatedProduct;

        // إصدار حالة النجاح مع قائمة جديدة لضمان إعادة البناء
        emit(ProductsSuccessState(List.from(cartsList)));
      },
    );
  }



}
