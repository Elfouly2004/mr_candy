
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../model/cart_model.dart';

abstract class CartsRepo {



  Future<Either<Failure, List<CartItemModel>>> getCarts();

  Future<Either<Failure, List<CartItemModel>>> updateCarts({
    required int IDcart,
    required int quantity,
  });

  Future<Either<Failure, CartItemModel>> DeleteCarts();

}