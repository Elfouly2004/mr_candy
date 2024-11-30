// // banners_model.dart
// class BannersModel {
//   final String urlImage;
//   final int id;
//   final String? category;
//   final String? product;
//
//   BannersModel({required this.urlImage,
//     required this.id,
//     required this.category,
//     required this.product});
//
// Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "image":urlImage,
//       "category":category,
//       "product":product
//     };
//   }
// }


class BannersModel {
  final String urlImage;
  final int id;
  final Map<String, dynamic>? category; // Update to handle category
  final String? product;

  BannersModel({
    required this.urlImage,
    required this.id,
    this.category, // Nullable category
    this.product, // Nullable product
  });


  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      urlImage: json['image'] ?? '',
      id: json['id'] ?? 0,
      category: json['category'],
      product: json['product'],
    );
  }

  // Method for serialization
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": urlImage,
      "category": category,
      "product": product,
    };
  }
}
