class TransactionModel {
  TransactionModel({this.transactions, this.currentBalance});

  final List<TrModel>? transactions;
  final String? currentBalance;

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactions: json['transactions'] != null
          ? List<TrModel>.from(
              (json['transactions'] as List).map(
                (item) => TrModel.fromJson(item),
              ),
            )
          : null,
      currentBalance: (json['current_balance'] ?? '').toString(),
    );
  }
}

class TrModel {
  TrModel({this.id, this.driverId, this.amount, this.type, this.desc,this.date});

  final int? id;
  final int? driverId;
  final String? amount;
  final String? type;
  final String? desc;
  final String? date ;

  factory TrModel.fromJson(Map<String, dynamic> json) {
    return TrModel(
      id: json['transactions'],
      driverId: json['driver_id'],
      amount: (json['amount'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      desc: (json['description'] ?? '').toString(),
      date:json['updated_at'].toString(),
    );
  }
}
