import 'dart:convert';

import 'package:lovard_delivery_app/models/product_model.dart';

class LinesModel {
  final int id;
  final int driverOrderId;
  final int productId;
  final double unitPrice;
  final int quantity;
  final double totalPrice;
  final double deliveryCost;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProductModel? product;

  LinesModel({
    required this.id,
    required this.driverOrderId,
    required this.productId,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
    required this.deliveryCost,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory LinesModel.fromJson(Map<String, dynamic> json) {
    return LinesModel(
      id: json['id'],
      driverOrderId: json['driver_order_id'],
      productId: json['product_id'],
      unitPrice: double.parse(json['unit_price']),
      quantity: json['quantity'],
      totalPrice: double.parse(json['total_price']),
      deliveryCost: double.parse(json['delivery_cost']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
    );
  }
}
