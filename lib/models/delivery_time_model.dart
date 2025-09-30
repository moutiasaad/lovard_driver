class DeliveryTimeModel {
  DeliveryTimeModel({
    this.id,
    this.start,
    this.end,
  });

  final int? id;
  final String? start;
  final String? end;

  factory DeliveryTimeModel.fromJson(Map<String, dynamic> json) {
    return DeliveryTimeModel(
      id: json['id'],
      start: json['start'] ?? '',
      end: json['end'] ?? '',
    );
  }
}
