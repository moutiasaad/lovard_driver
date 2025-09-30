class PromotionModel {
  PromotionModel({this.id, this.name, this.image});

  final int? id;
  final String? name;
  final String? image;

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      id: json['id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
