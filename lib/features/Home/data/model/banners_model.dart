// banners_model.dart
class BannersModel {
  final String urlImage;
  final int id;
  final String? category;
  final String? product;

  BannersModel({required this.urlImage,
    required this.id,
    required this.category,
    required this.product});

Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image":urlImage,
      "category":category,
      "product":product
    };
  }
}
