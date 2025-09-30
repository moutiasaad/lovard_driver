class DriverStatus {
  final int id;
  final String statusName;
  final String statusColor; // hex string like "#4CAF50"
  final DateTime createdAt;
  final DateTime updatedAt;

  DriverStatus({
    required this.id,
    required this.statusName,
    required this.statusColor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DriverStatus.fromJson(Map<String, dynamic> json) {
    return DriverStatus(
      id: json['id'] as int,
      statusName: json['status_name'] as String,
      statusColor: json['status_color'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
