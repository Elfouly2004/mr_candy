import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrcandy/features/Home/data/model/categories_model.dart';
import '../../../data/repo/home_repo_implemetation.dart';
import 'get_categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitialState());

  final HomeRepoImplementation homeRepo = HomeRepoImplementation();
  List<CategoriesModel> categories_lst = [];

  // Static method for accessing the cubit instance easily
  static CategoriesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchBanners() async {
    emit(CategoriesLoadingState());

    final result = await homeRepo.get_categories();
    result.fold((failure) {
      print("Error fetching banners: ${failure.message}");
      emit(CategoriesFailureState(errorMessage: failure.message));
    }, (data) {
      categories_lst = data;
      print("Fetched banners: $categories_lst");  // Debug output
      emit(CategoriesSuccessState());
    },
    );
  }

}
