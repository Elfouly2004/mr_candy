import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mrcandy/features/Home/data/model/product_model.dart';

import '../../../Home/data/repo/home_repo_implemetation.dart';
import '../../data/repo/catgories_repo_implementation.dart';

part 'catgories_deatils_state.dart';

class CatgoriesDeatilsCubit extends Cubit<CatgoriesDeatilsState> {
  CatgoriesDeatilsCubit() : super(CatgoriesDeatilsInitial());



  final CatgoriesRepoImplementation homeRepo = CatgoriesRepoImplementation();
  List<ProductModel> categoriesdeatials_lst = [];

  static CatgoriesDeatilsCubit get(context) => BlocProvider.of(context);

  Future<void> fetch_catgories_details({required int categoryId}) async {
    emit(CategoriesLoadingState());

    final result = await homeRepo.get_catgories_deatils(id: categoryId);

    result.fold((failure) {
      print("Error fetching banners: ${failure.message}");
      emit(CategoriesFailureState(errorMessage: failure.message));
    }, (data) {
      categoriesdeatials_lst = data;  // تأكد أن 'data' من نوع 'List<ProductModel>'
      print("Fetched banners: $categoriesdeatials_lst");
      emit(CategoriesSuccessState());
    });
  }

}


