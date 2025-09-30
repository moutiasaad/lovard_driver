

class AdsModel {
  AdsModel({
    this.id,
    this.name,
    this.image,
  });

  final int? id;
  final String? name;
  final String? image;

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
