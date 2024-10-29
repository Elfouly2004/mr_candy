import 'package:dartz/dartz.dart';
import 'package:mrcandy/features/Home/data/model/categories_model.dart';

import '../../../../core/errors/failure.dart';
import '../model/banners_model.dart';

abstract class HomeRepo {


  Future<Either<Failure,List<BannersModel>>> get_banners();


  Future<Either<Failure,List<CategoriesModel>>> get_categories();




}