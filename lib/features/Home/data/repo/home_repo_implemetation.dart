import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/endpoints.dart';
import '../model/banners_model.dart';
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
}
