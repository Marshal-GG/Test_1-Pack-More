import '../../../models/models.dart';

abstract class BasePaymentsRepository {
  Future<void> addPayment({
    required OrderDetails orderDetails,
    required String orderId,
    required String status,
    required String paymentMethod,
    required String amount,
  });
}
