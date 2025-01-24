import '../../../Home/data/model/product_model.dart';

class CartItemModel {
  final int id;
  final int quantity;
  final ProductModel product;

  CartItemModel({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] ?? 0, // Default to 0 if null
      quantity: json['quantity'] ?? 0, // Default to 0 if null
      product: ProductModel.fromJson(json['product'] ?? {}), // Default to empty object if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'product': product.toJson(),
    };
  }
}
