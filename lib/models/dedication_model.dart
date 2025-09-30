class DedicationModel {
  DedicationModel({
    this.name,
  });

  final String? name;

  factory DedicationModel.fromJson(Map<String, dynamic> json) {
    return DedicationModel(
      name: json['dedication_name'] ?? '',
    );
  }
}

class CategoryModel {
  final String categoryName;
  final List<DedicationModel> dedications;

  CategoryModel({required this.categoryName, required this.dedications});

  /// Parse JSON data into a list of CategoryModel
  static List<CategoryModel> fromJsonMap(Map<String, dynamic> json) {
    return json.entries.map((entry) {
      final String categoryName = entry.key;
      final List<dynamic> dedicationList = entry.value;
      final dedications = dedicationList
          .map((dedicationJson) => DedicationModel.fromJson(dedicationJson))
          .toList();

      return CategoryModel(
        categoryName: categoryName,
        dedications: dedications,
      );
    }).toList();
  }
}
