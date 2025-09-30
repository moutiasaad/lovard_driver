class ClientModel {
  ClientModel({
    this.id,
    this.phone,
    this.address,
    this.fullName,
    this.email,
  });

  final int? id;
  final String? phone;
  final String? address;
  final String? fullName;
  final String? email;

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      fullName: json['fullname'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
