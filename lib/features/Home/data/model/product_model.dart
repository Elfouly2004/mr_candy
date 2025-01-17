
import 'package:equatable/equatable.dart';

class ProductModel  extends Equatable{
  int id;
  int price;
  int oldPrice;
  int discount;
  String image;
  String name;
  String description;
  List<String> images;
  bool inFavorites;
  bool inCart;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavorites,
    required this.inCart,

  }

  );

  // Factory constructor to create a new Product instance from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] is int ? json['id'] : (json['id'] as double?)?.toInt() ?? 0, // Default to 0 if null
      price: json['price'] is int ? json['price'] : (json['price'] as double?)?.toInt() ?? 0, // Default to 0 if null
      oldPrice: json['old_price'] is int ? json['old_price'] : (json['old_price'] as double?)?.toInt() ?? 0, // Default to 0 if null
      discount: json['discount'] is int ? json['discount'] : (json['discount'] as double?)?.toInt() ?? 0, // Default to 0 if null
      image: json['image'] ?? '', // Default to empty string if null
      name: json['name'] ?? '', // Default to empty string if null
      description: json['description'] ?? '', // Default to empty string if null
      images: json['images'] != null && json['images'] is List
          ? List<String>.from(json['images'])
          : [], // Default to empty list if null or not a list
      inFavorites: json['in_favorites'] ?? false, // Default to false if null
      inCart: json['in_cart'] ?? false, // Default to false if null
    );
  }


  // Method to convert a Product instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'old_price': oldPrice,
      'discount': discount,
      'image': image,
      'name': name,
      'description': description,
      'images': images,
      'in_favorites': inFavorites,
      'in_cart': inCart,
    };
  }


  @override
  List<Object?> get props => [id, name, image,images, price,oldPrice, discount, inFavorites,inCart,description];



}




