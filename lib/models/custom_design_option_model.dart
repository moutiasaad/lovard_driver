

class CustomDesignOptionModel {
  CustomDesignOptionModel({
    this.id,
    this.title,
    this.image,
    this.type,
    this.price,
  });

  final int? id;
  final String? title;
  final String? image;
  final String? type;
  final String? price;

  factory CustomDesignOptionModel.fromJson(Map<String, dynamic> json) {
    return CustomDesignOptionModel(
      id: json['id'],
      title: json['title'],
      image: json['img'] ?? '',
      type: json['type'],
      price: json['price'],
    );
  }
}
