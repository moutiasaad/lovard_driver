import 'merchant_model.dart';

class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.image,
    this.desc,
    this.type,
    this.sku,
    this.categoryId,
    this.merchantId,
    this.price,
    this.discountPrice,
    this.discountStart,
    this.discountEnd,
    this.isFavorite,
    this.merchant,
    this.isCustom,
    this.attributes,
    this.categoryName,
  });

  final int? id;
  final String? name;
  final List<dynamic>? image;
  final String? desc;
  final String? type;
  final String? sku;
  final int? categoryId;
  final int? merchantId;
  final String? price;
  final String? discountPrice;
  final String? discountStart;
  final String? discountEnd;
  final bool? isFavorite;
  final MerchantModel? merchant;
  final bool? isCustom;
  final Map<String,dynamic>? attributes;
  final String? categoryName;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'] ?? '',
      image: json['image'] ?? [],
      desc: json['description'] ?? '',
      type: json['type'],
      sku: json['sku'],
      categoryId: json['category_id'],
      merchantId: json['merchant_id'] ?? '',
      price: json['price'] ?? '',
      discountPrice: json['discount_price'] ?? '',
      discountStart: json['discount_start'] ?? '',
      discountEnd: json['discount_end'] ?? '',
      isFavorite: json['is_wishlisted'],
      merchant: json['merchant'] != null
          ? MerchantModel.fromJson(json['merchant'])
          : null,
      isCustom: json['product_type'] == 1 ? true : false,
      attributes: json['attributes'],
      categoryName: json['category']?['name']?? '',
    );
  }
}
