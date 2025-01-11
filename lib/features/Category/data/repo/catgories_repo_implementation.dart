
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:mrcandy/core/errors/failure.dart';

import 'package:mrcandy/features/Home/data/model/product_model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../core/utils/endpoints.dart';

import '../../presentation/controller/catgories_deatils_cubit.dart';
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

  Future<Either<Failure, ProductModel>> Addfav({context,index}) async {

    print("tttttttttttttt is ${Hive.box("setting").get("token")}");
    final token = Hive.box("setting").get("token");
    if (token == null || token.isEmpty) {
      print("Error: Token is missing or invalid");
      return left(ApiFailure(message: "Authentication token is missing."));
    }


    try {
      final Map<String, dynamic> body =
      {
        "product_id": BlocProvider.of<CatgoriesDeatilsCubit>(context).categoriesdeatials_lst[index].id.toString()};
      // Define the request body
      final response = await http.post(
          Uri.parse(EndPoints.baseUrl + EndPoints.favorites),
          headers: {
            "Authorization": "$token",  // تأكد أن هذا التوكن صحيح
          },
          body: body

      );

      print("RRRRRRRRRRRRRRRRRR     ${response.body}");

      print("iddddddddddddd = ${BlocProvider.of<CatgoriesDeatilsCubit>(context).categoriesdeatials_lst[index].id}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody["status"] == true) {
          // طلب ناجح
          final productData = responseBody["data"]["product"];
          final productModel = ProductModel.fromJson(productData);
          return right(productModel);


        } else {
          // فشل بسبب عدم التصريح
          return left(ApiFailure(message: responseBody["message"] ?? "Failed to add to favorites"));
        }
      } else {
        return left(ApiFailure(message: "Failed to fetch data, Status code: ${response.statusCode}"));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet"));
    } catch (e) {
      print('Error occurred: $e'); // Debugging log
      return left(ApiFailure(message: "Error Occurred"));
    }
  }


}


