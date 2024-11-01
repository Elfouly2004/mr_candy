

import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mrcandy/core/errors/failure.dart';
import 'package:mrcandy/features/login/data/model/user_model.dart';
import '../../../../core/utils/endpoints.dart';
import '../model/model.dart';
import 'Greate_account_repo.dart';
import 'package:http/http.dart'as http;


class  GreateAccountImpelemntation implements GreateAccountRepo{
  @override
  Future<Either<Failure, UserModel>> Greate_account(
      {required UserModelToRegister userModelToRegister}) async {

    try  {
      var result  =await http.post(Uri.parse(EndPoints.baseUrl+EndPoints.regisrer),
          body: userModelToRegister.toJson()
      );
      var body = jsonDecode( result.body);
      if(body["status"]){

        return  right(UserModel(
            id: body["data"]["id"],
            name: body["data"]["name"],
            email: body["data"]["email"],
            phone: body["data"]["phone"],
            image: body["data"]["image"],
            points: body["data"]["points"],
            credit: body["data"]["credit"],
            token: body["data"]["token"]));
      }else{

        return left(ApiFailure(message: body["message"]));
      }

    }on SocketException{
      return left(NoInternetFailure(message: "No Internet"));
    }
    catch(e) {
      return left(ApiFailure(message: e.toString()));
    }

  }
}