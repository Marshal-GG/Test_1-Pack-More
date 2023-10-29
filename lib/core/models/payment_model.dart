class Payment {
  final String paymentId;
  final String userUid;
  final String orderId;
  final double amount;
  final String paymentMethod;
  final DateTime timestamp;

  Payment({
    required this.paymentId,
    required this.userUid,
    required this.orderId,
    required this.amount,
    required this.paymentMethod,
    required this.timestamp,
  });
}