import 'package:equatable/equatable.dart';
import '../routes/routes_config.dart';

class Payment extends Equatable {
  final String paymentId;
  final String userUid;
  final String orderId;
  final String status;
  final String amount;
  final String paymentMethod;
  final Timestamp timestamp;

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
    Timestamp? timestamp,
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

  static Payment fromDocument(data) {
    return Payment(
      paymentId: data['paymentId'],
      userUid: data['userUid'],
      orderId: data['orderId'],
      status: data['status'],
      amount: data['amount'],
      paymentMethod: data['paymentMethod'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'paymentId': paymentId,
      'userUid': userUid,
      'orderId': orderId,
      'status': status,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'timestamp': timestamp,
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
