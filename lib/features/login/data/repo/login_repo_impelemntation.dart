import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart'as http;
import 'package:mrcandy/core/utils/endpoints.dart';
import '../../../../core/errors/failure.dart';
import '../model/user_model.dart';
import 'login_repo.dart';
class LoginRepoImplementation implements LoginRepo {
  @override



  Future<Either<Failure, UserModel>> login(
      {
        required String email,
        required String pass
      }
      )async{

    try  {
      var result  =await http.post(Uri.parse(EndPoints.baseUrl+EndPoints.login),
          body:{"email": email, "password": pass});
      var body = jsonDecode( result.body);
      if(body["status"]){

        return  right(UserModel(
            id: body["data"]["id"], name: body["data"]["name"],
            email: body["data"]["email"], phone: body["data"]["phone"],
            image: body["data"]["image"], points: body["data"]["points"],
            credit: body["data"]["credit"], token: body["data"]["token"]));
      }else{

        return left(ApiFailure(message: body["message"]));
      }

    }on SocketException{
      return left(NoInternetFailure(message: "No Internet"));
    }
    catch(e) {
      return left(ApiFailure(message: "Error Occurred"));
    }




  }

}