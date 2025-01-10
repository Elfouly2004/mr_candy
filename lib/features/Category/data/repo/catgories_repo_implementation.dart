
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:mrcandy/core/errors/failure.dart';

import 'package:mrcandy/features/Home/data/model/product_model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../core/utils/endpoints.dart';

import 'catgories_repo.dart';

class CatgoriesRepoImplementation implements CatgoriesRepo {

  @override

  Future<Either<Failure, List<ProductModel>>> get_catgories_deatils({required int id}) async {

    final token = Hive.box("setting").get("token");
    if (token == null || token.isEmpty) {
      print("Error: Token is missing or invalid");
      return left(ApiFailure(message: "Authentication token is missing."));
    }


    try {
      // إعداد الـ headers إذا لزم الأمر
      // final headers = {
      //   'Authorization': 'Bearer YOUR_TOKEN',
      //   'Content-Type': 'application/json',
      // };

      // إرسال الطلب
      final response = await http.get(
        Uri.parse("${EndPoints.baseUrl + EndPoints.categories}/$id"),
        // headers: headers,

      );

      // التحقق من حالة الاستجابة
      if (response.statusCode != 200) {
        return left(ApiFailure(message: "Failed to fetch data: ${response.statusCode}"));
      }

      final body = jsonDecode(response.body);

      // التحقق من هيكل الاستجابة وتحويل البيانات باستخدام fromJson
      if (body["status"] == true && body["data"] != null) {

        final categories = (body["data"]["data"] as List)
            .map((categorie) => ProductModel.fromJson(categorie))
            .toList();
        return right(categories);
      } else {
        return left(ApiFailure(message: body["message"] ?? "Unknown error"));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet Connection"));
    } catch (e) {
      print('Error occurred: $e'); // طباعة الخطأ لتتبع المشكلة
      return left(ApiFailure(message: "Error Occurred: $e"));
    }
  }
}


