import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  final String paymentId;
  final String userUid;
  final String orderId;
  final String status;
  final String amount;
  final String paymentMethod;
  final DateTime timestamp;

  Payment({
    required this.paymentId,
    required this.userUid,
    required this.orderId,
    required this.status,
    required this.amount,
    required this.paymentMethod,
    required this.timestamp,
  });

  Payment copyWith({
    String? paymentId,
    String? userUid,
    String? orderId,
    String? status,
    String? amount,
    String? paymentMethod,
    DateTime? timestamp,
  }) {
    return Payment(
      paymentId: paymentId ?? this.paymentId,
      userUid: userUid ?? this.userUid,
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  static Payment fromMap(Map<String, dynamic> data) {
    return Payment(
      paymentId: data['paymentId'] ?? '',
      userUid: data['userUid'] ?? '',
      orderId: data['orderId'] ?? '',
      status: data['status'] ?? '',
      amount: data['amount'] ?? '',
      paymentMethod: data['paymentMethod'] ?? '',
      timestamp: data['timestamp'] != null
          ? DateTime.parse(data['timestamp'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paymentId': paymentId,
      'userUid': userUid,
      'orderId': orderId,
      'status': status,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'timestamp': timestamp.toUtc().toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        paymentId,
        userUid,
        orderId,
        status,
        amount,
        paymentMethod,
        timestamp,
      ];
}
