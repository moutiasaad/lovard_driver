

class CustomDesignModel {
  CustomDesignModel({
    this.id,
    this.title,
    this.image,
  });

  final int? id;
  final String? title;
  final String? image;

  factory CustomDesignModel.fromJson(Map<String, dynamic> json) {
    return CustomDesignModel(
      id: json['id'],
      title: json['title'],
      image: json['img'] ?? '',
    );
  }
}
