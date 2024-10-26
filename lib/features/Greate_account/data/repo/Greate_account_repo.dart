

import 'package:mrcandy/features/Greate_account/data/model/model.dart';

import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../login/data/model/user_model.dart';
abstract class GreateAccountRepo {

  Future<Either<Failure , UserModel>> Greate_account(
      {
        required UserModelToRegister userModelToRegister

      }
      ) ;

}