import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:mrcandy/features/Home/data/model/categories_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/endpoints.dart';
import '../../presentation/controller/get_product/get_product_cubit.dart';
import '../model/banners_model.dart';
import '../model/product_model.dart';
import 'home_repo.dart';

class HomeRepoImplementation implements HomeRepo {


  // قائمة المنتجات المخزنة في الريبو
  List<ProductModel> productList = [];



  @override
  Future<Either<Failure, List<BannersModel>>> get_banners() async {
    List<BannersModel> banners = [];
    try {
      final response = await http.get(Uri.parse(EndPoints.baseUrl + EndPoints.banners));
      final body = jsonDecode(response.body);

      if (body["status"] == true) {
        for (var banner in body["data"]) {
          banners.add(BannersModel(
            urlImage: banner["image"],
            id: banner["id"],
            category: banner["category"],
            product: banner["product"],
          ));
        }
        return right(banners);
      } else {
        return left(ApiFailure(message: body["message"]));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet"));
    } catch (e) {
      print('Error occurred: $e');  // Print the error
      return left(ApiFailure(message: "Error Occurred"));
    }
  }

  @override
  Future<Either<Failure, List<CategoriesModel>>> get_categories() async {
    List<CategoriesModel> categories_lst = [];
    try {
      final response = await http.get(Uri.parse(EndPoints.baseUrl + EndPoints.categories));
      final body = jsonDecode(response.body);

      if (body["status"] == true) {
        for (var categorie in body["data"]["data"]) {
          categories_lst.add(
            CategoriesModel(
              urlImage: categorie["image"],
              id: categorie["id"],
              name: categorie["name"],
            ),
          );
        }
        return right(categories_lst);
      } else {
        return left(ApiFailure(message: body["message"]));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet"));
    } catch (e) {
      print('Error occurred: $e');  // Print the error
      return left(ApiFailure(message: "Error Occurred"));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> get_product() async {
    try {
      final response = await http.get(Uri.parse(EndPoints.baseUrl + EndPoints.home));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print('Response data: ${body["data"]["data"]}');

        if (body["status"] == true) {
          productList = []; // Clear the list before populating it

          // Iterate over body["data"]["products"] instead of body["data"]
          for (var product in body["data"]["data"]) {
            productList.add(ProductModel.fromJson(product));
          }
          return right(productList);
        } else {
          return left(ApiFailure(message: body["message"] ?? "Unknown error occurred"));
        }
      } else {
        return left(ApiFailure(message: "Failed to fetch data, Status code: ${response.statusCode}"));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet"));
    } catch (e) {
      print('Error occurred: $e'); // Print the error for debugging
      return left(ApiFailure(message: "Error Occurred"));
    }
  }



  @override
  Future<Either<Failure, List<ProductModel>>> get_Gatgories({id}) async {
    try {
      final response = await http.get(Uri.parse("${EndPoints.baseUrl + EndPoints.categories}/${id}"));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print('Response data: ${body["data"]["products"]}');

        if (body["status"] == true) {
          productList = []; // تأكد من تفريغ القائمة قبل ملئها
          for (var product in body["data"]["products"]) {
            productList.add(ProductModel.fromJson(product));
          }
          return right(productList);
        } else {
          return left(ApiFailure(message: body["message"]));
        }
      } else {
        return left(ApiFailure(message: "Failed to fetch data, Status code: ${response.statusCode}"));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet"));
    } catch (e) {
      print('Error occurred: $e');  // Print the error for debugging
      return left(ApiFailure(message: "Error Occurred"));
    }
  }

  @override

  Future<Either<Failure, ProductModel>> Addfav({context,index}) async {

    print("tttttttttttttt is ${Hive.box("setting").get("token")}");
    final token = Hive.box("setting").get("token");
    if (token == null || token.isEmpty) {
      print("Error: Token is missing or invalid");
      return left(ApiFailure(message: "Authentication token is missing."));
    }


    try {
      final Map<String, dynamic> body = {"product_id":BlocProvider.of<ProductsCubit>(context).productList[index].id};
      // Define the request body
      final response = await http.post(
        Uri.parse(EndPoints.baseUrl + EndPoints.favorites),
          headers: {
            "lang":"ar",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",  // تأكد أن هذا التوكن صحيح
          },

        body: jsonEncode(body),
      );

print("iddddddddddddd = ${BlocProvider.of<ProductsCubit>(context).productList[index].id}");
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


  @override
  List<ProductModel> favlist = [];


  Future<Either<Failure, List<ProductModel>>> getfav() async {


    final token = Hive.box("setting").get("token");


    try {
      final response = await http.get(Uri.parse(EndPoints.baseUrl + EndPoints.favorites),
        headers: {
        "lang":"ar",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",  // تأكد أن هذا التوكن صحيح
      },




      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print('Response data: ${body["data"]}');

        if (body["status"] == true) {
          favlist = []; // تأكد من تفريغ القائمة قبل ملئها
          for (var product in body["data"]["data"]) {
            favlist.add(ProductModel.fromJson(product));
          }
          return right(favlist);
        } else {
          return left(ApiFailure(message: body["message"]));
        }
      } else {
        return left(ApiFailure(message: "Failed to fetch data, Status code: ${response.statusCode}"));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet"));
    } catch (e) {
      print('Error occurred: $e');  // Print the error for debugging
      return left(ApiFailure(message: "Error Occurred"));
    }
  }


}
