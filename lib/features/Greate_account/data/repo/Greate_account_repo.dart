

import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../login/data/model/user_model.dart';
abstract class GreateAccountRepo {

  Future<Either<Failure , UserModel>> Greate_account(
      {
        required String  photo ,
        required String  name ,
        required String  email ,
        required String phone,
        required String password
      }
      ) ;

}