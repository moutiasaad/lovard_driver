import 'lines_model.dart';
import 'merchant_model.dart';

class OrderModel {
  OrderModel({
    this.id,
    this.merchant,
    this.lines,
    this.clientNote,
    this.adminNote,
    this.startDeliveryDate,
    this.endDeliveryDate,
    this.address,
    this.phone,
    this.fullName,
    this.deliveryCost,
    this.driverId,
    this.status,
    this.merchantId,
    this.latitudeC,
    this.longitudeC,
    this.latitudeM,
    this.longitudeM,
    this.statusColor,
    this.orderStatus,
  });

  final int? id;
  final int? merchantId;
  final String? address;
  final String? phone;
  final String? fullName;
  final String? deliveryCost;
  final String? status;
  final String? statusColor;
  final String? clientNote;
  final String? adminNote;
  final String? startDeliveryDate;
  final String? endDeliveryDate;
  final String? latitudeC;
  final String? longitudeC;
  final String? latitudeM;
  final String? longitudeM;
  final int? driverId;
  final MerchantModel? merchant;
  final LinesModel? lines;
  final List<OrderStatusC>? orderStatus;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: int.parse(json['order_id'].toString()),
      merchantId: int.parse(json['merchant_id'].toString()),

      address: json['address'],
      latitudeM: json['latitude_marchent'],
      longitudeM: json['longitude_marchent'],
      latitudeC: json['latitude_client'],
      longitudeC: json['longitude_client'],
      phone: json['phone'],
      fullName: json['fullname'],
      status: json['status'].toString(),
      clientNote: json['client_note'],
      adminNote: json['admin_note'],
      startDeliveryDate: json['start_date_delivery'],
      deliveryCost: json['delivery_cost'],
      endDeliveryDate: json['end_date_delivery'],
      driverId: json['driver_id'],
      merchant: json['merchant'] != null
          ? MerchantModel.fromJson(json['merchant'])
          : null,
      lines:
          json['lines'] != null ? LinesModel.fromJson(json['lines'][0]) : null,
      statusColor: json['status_color'] ?? '',
      orderStatus: json['order_status'] != null
          ? List<OrderStatusC>.from(
              (json['order_status'] as List).map(
                (item) => OrderStatusC.fromJson(item),
              ),
            )
          : null,
    );
  }
}

class OrderStatusC {
  OrderStatusC({this.title, this.date, this.status});

  final String? title;
  final String? date;
  final String? status;

  factory OrderStatusC.fromJson(Map<String, dynamic> json) {
    return OrderStatusC(
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      status: (json['status'] ?? '').toString(),
    );
  }
}
