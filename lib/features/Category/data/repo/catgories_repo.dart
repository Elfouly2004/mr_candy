
import 'package:dartz/dartz.dart';


import '../../../../core/errors/failure.dart';
import '../../../Home/data/model/product_model.dart';
import '../../../carts/data/model/cart_model.dart';

abstract class CatgoriesRepo {


  Future<Either<Failure,  List<ProductModel>>>get_catgories_deatils({required int id});

  Future<Either<Failure, ProductModel>> Addfav();

  Future<Either<Failure, CartItemModel>> Add_carts();



}