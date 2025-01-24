// Categories_model.dart
class CategoriesModel {
  final int id;
  final String urlImage;

  final String name;

  CategoriesModel({
    required this.urlImage,
    required this.id,
    required this.name,

  }
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image":urlImage,
      "name":name,
    };
  }
}
