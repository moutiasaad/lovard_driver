class OfferModel {
  OfferModel({this.id, this.name, this.image});

  final int? id;
  final String? name;
  final String? image;

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
