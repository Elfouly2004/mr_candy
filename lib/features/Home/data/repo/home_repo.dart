import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../model/banners_model.dart';

abstract class HomeRepo {


  Future<Either<Failure,List<BannersModel>>> get_banners();




}