class NotificationModel {
  NotificationModel({this.title, this.body, this.type,this.date});

  final String? title;
  final String? body;
  final String? type;
  final String? date;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      type: json['type'] ?? '',
      date: json['created_at'] ?? '',

    );
  }
}
