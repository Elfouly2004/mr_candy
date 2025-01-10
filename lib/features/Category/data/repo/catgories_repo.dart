
import 'package:dartz/dartz.dart';


import '../../../../core/errors/failure.dart';
import '../../../Home/data/model/product_model.dart';

abstract class CatgoriesRepo {


  Future<Either<Failure,  List<ProductModel>>>get_catgories_deatils({required int id});


}