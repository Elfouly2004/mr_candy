

import '../../../../core/errors/failure.dart';
import '../model/user_model.dart';
import 'package:dartz/dartz.dart';
abstract class LoginRepo {

  Future<Either<Failure , UserModel>> login({required String  email , required String pass} ) ;

}