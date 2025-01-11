import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Home/data/model/product_model.dart';
import '../../../Home/data/repo/home_repo_implemetation.dart';
import 'fav_state.dart';


class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitialState());

  final HomeRepoImplementation homeRepo = HomeRepoImplementation();
  List<ProductModel> favoritesList = [];

  static FavoritesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchFavorites() async {
    emit(FavoritesLoadingState());
    final result = await homeRepo.getfav();

    result.fold(
          (failure) {
        print("Error fetching favorites: ${failure.message}");
        emit(FavoritesFailureState(failure.message));
      },
          (data) {
        favoritesList = data; // حفظ البيانات في القائمة
        emit(FavoritesSuccessState(data));
      },
    );
  }
}
