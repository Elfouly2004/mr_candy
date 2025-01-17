import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:mrcandy/features/Home/data/model/product_model.dart';
import 'package:mrcandy/features/carts/data/model/cart_model.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/utils/endpoints.dart';
import '../../../../Home/data/repo/home_repo_implemetation.dart';
import '../../../../Home/presentation/controller/get_product/get_product_cubit.dart';
import '../../../data/repo/catgories_repo_implementation.dart';

part 'catgories_sections _state.dart';

class CatgoriesSectionsCubit extends Cubit<CatgoriesSectionsState> {
  CatgoriesSectionsCubit() : super(CatgoriesSectionsInitial());



  final CatgoriesRepoImplementation CatgoriesRepo = CatgoriesRepoImplementation();
  List<ProductModel> categoriesdeatials_lst = [];
  List<CartItemModel> carts_categoriesdeatials_lst = [];


  static CatgoriesSectionsCubit get(context) => BlocProvider.of(context);

  Future<void> fetch_catgories_details({required int categoryId}) async {
    emit(CategoriesLoadingState());

    final result = await CatgoriesRepo.get_catgories_deatils(id: categoryId);

    result.fold((failure) {
      print("Error fetching banners: ${failure.message}");
      emit(CategoriesFailureState(errorMessage: failure.message));
    }, (data) {
      categoriesdeatials_lst = data;  // تأكد أن 'data' من نوع 'List<ProductModel>'
      print("Fetched banners: $categoriesdeatials_lst");

      emit(CategoriesSuccessState());
    });
  }


  Future<void> addFavorite(context, int index) async {
    final result = await CatgoriesRepo.Addfav(context: context, index: index);

    result.fold(
          (failure) {
        print("Error adding to favorites: ${failure.message}");
        emit(CategoriesFailureState(errorMessage: failure.message));
      },
          (updatedProduct) {
        print("Product added to favorites: $updatedProduct");

        // تحديث المنتج في القائمة المحلية
        categoriesdeatials_lst[index] = updatedProduct;
        categoriesdeatials_lst[index].inFavorites = !categoriesdeatials_lst[index].inFavorites;
        // إصدار حالة النجاح مع قائمة جديدة لضمان إعادة البناء
        emit(CategoriesSuccessState());
      },
    );
  }


  Future<void> addCart(context, int index) async {
    final result = await CatgoriesRepo.Add_carts(context: context, index: index);

    result.fold(
          (failure) {
        emit(CategoriesFailureState(errorMessage: failure.message));
      },
          (updatedProduct) {

            carts_categoriesdeatials_lst[index] = updatedProduct;

        // إصدار حالة النجاح مع قائمة جديدة لضمان إعادة البناء
        emit(CategoriesSuccessState());
      },
    );
  }





}


