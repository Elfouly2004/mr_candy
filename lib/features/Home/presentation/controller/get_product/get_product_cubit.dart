import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrcandy/features/Home/data/model/categories_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/repo/home_repo_implemetation.dart';
import 'get_product_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitialState());

  final HomeRepoImplementation homeRepo = HomeRepoImplementation();
  List<ProductModel> productList = [];

  // Static method for accessing the cubit instance easily
  static ProductsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchproducts() async {
    emit(ProductsLoadingState());

    final result = await homeRepo.get_product();
    result.fold((failure) {
      print("Error fetching banners: ${failure.message}");

      emit(ProductsFailureState(errorMessage: failure.message));
    }, (data) {
      productList = data;
      print("Fetched banners: $productList");  // Debug output
      emit(ProductsSuccessState(productList));
    },
    );
  }


}
