
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../Home/data/model/product_model.dart';
import '../model/cart_model.dart';

abstract class CartsRepo {


  Future<Either<Failure, CartItemModel>> Add_carts();

  Future<Either<Failure, List<CartItemModel>>> getCarts();

}