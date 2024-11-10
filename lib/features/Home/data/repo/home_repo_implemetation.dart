import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mrcandy/features/Home/data/model/categories_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/endpoints.dart';
import '../model/banners_model.dart';
import '../model/product_model.dart';
import 'home_repo.dart';

class HomeRepoImplementation implements HomeRepo {

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
  Future<Either<Failure, List<CategoriesModel>>> get_categories()async {
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
            name: categorie["name"]
          ));
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
    List<ProductModel> productList = [];

    try {
      final response = await http.get(Uri.parse(EndPoints.baseUrl + EndPoints.home));

      if (response.statusCode == 200) {

        final body = jsonDecode(response.body);
        print('Response data: ${body["data"]["products"]}');

        if (body["status"] == true) {
          // Adjust this part based on the printed structure
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







  }







