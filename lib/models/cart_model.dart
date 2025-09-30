

import 'package:lovard_delivery_app/models/product_model.dart';

class CartModel {
  CartModel({
    this.id,
    this.userId,
    this.preferredDeliveryStart,
    this.preferredDeliveryEnd,
    this.qte,
    this.product,
  });

  final int? id;
  final int? userId;
  final String? preferredDeliveryStart;
  final String? preferredDeliveryEnd;
  final int? qte;
  final ProductModel? product;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['user_id'],
      preferredDeliveryStart: json['preferred_delivery_start'] ?? '',
      preferredDeliveryEnd: json['preferred_delivery_end'] ?? '',
      qte: json['qte'],
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
    );
  }
}
