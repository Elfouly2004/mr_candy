import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mrcandy/core/errors/failure.dart';
import '../../../../core/utils/endpoints.dart';
import 'package:http/http.dart' as http;
import '../model/model.dart';
import 'Greate_account_repo.dart';

class GreateAccountImplementation implements GreateAccountRepo {
  @override
  Future<Either<Failure, UserModelToRegister>> Greate_account({
    required UserModelToRegister userModelToRegister,
  }) async {
    try {
      // Construct the API endpoint
      final uri = Uri.parse(EndPoints.baseUrl + EndPoints.regisrer);

      // Send the POST request
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userModelToRegister.toJson()), // Encode body as JSON
      );

      // Decode the response body
      final Map<String, dynamic> body = jsonDecode(response.body);

      // Check the status of the response
      if (body["status"] == true) {
        // Return the same UserModelToRegister instance as a success response
        return right(userModelToRegister);
      } else {
        // Return failure with the message from the response
        return left(ApiFailure(message: body["message"] ?? "Unknown error"));
      }
    } on SocketException {
      // Handle no internet connection error
      return left(NoInternetFailure(message: "No Internet connection"));
    } catch (e) {
      // Handle any other unexpected errors
      return left(ApiFailure(message: e.toString()));
    }
  }
}