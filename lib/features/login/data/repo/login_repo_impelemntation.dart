import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:mrcandy/core/utils/app_texts.dart';
import 'package:mrcandy/core/utils/endpoints.dart';
import '../../../../core/errors/failure.dart';
import '../model/user_model.dart';
import 'login_repo.dart';

class LoginRepoImplementation implements LoginRepo {
  @override
  Future<Either<Failure, UserModel>> login({required String email, required String pass}) async {
    try {
      final response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": pass,
        }),
      );

      final responseBody = jsonDecode(response.body);
      print("Response: $responseBody");

      if (response.statusCode == 200 && responseBody["status"] == true) {
        final user = UserModel.fromJson(responseBody["data"]);
        return right(user);
      } else {
        return left(ApiFailure(message: responseBody["message"] ?? "Login failed"));
      }
    } catch (e) {
      print("Error: $e");
      return left(ApiFailure(message: "Unexpected error occurred"));
    }
  }

}
