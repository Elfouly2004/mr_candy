import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrcandy/features/Home/data/model/categories_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/repo/home_repo_implemetation.dart';
import 'get_product_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitialState());

  final HomeRepoImplementation homeRepo = HomeRepoImplementation();

  // قائمة المنتجات التي سيتم تعبئتها بالبيانات بعد جلبها
  List<ProductModel> productList = [];

  // Static method for accessing the cubit instance easily
  static ProductsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchproducts() async {
    emit(ProductsLoadingState());

    final result = await homeRepo.get_product();
    result.fold((failure) {
      print("Error fetching products: ${failure.message}");
      emit(ProductsFailureState(errorMessage: failure.message));
    }, (data) {
      productList = data;  // تعبئة productList بالبيانات المأخوذة من الريبو
      print("Fetched products: $productList");  // Debug output
      emit(ProductsSuccessState(productList));
    });
  }



  Future<void> addFavorite(context, index) async {

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

        // إصدار حالة النجاح مع القائمة الجديدة
        emit(AddFavoriteSuccessState(updatedProduct));
        emit(ProductsSuccessState(productList)); // تحديث كامل للواجهة إذا كانت تعتمد على القائمة
      },
    );
  }


}
