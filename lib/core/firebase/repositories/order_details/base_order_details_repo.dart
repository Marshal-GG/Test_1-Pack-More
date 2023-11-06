import '../../../models/models.dart';

abstract class BaseOrderDetailsRepository {
  Future<Map<String, dynamic>> addOrderDetails();
  Future<List<OrderDetails>> fetchAllOrderDetails();
  Future<OrderDetails?> fetchOrderDetailsByOrderId({required String orderId});
  Future<double> calculateSubTotalPrice();
  double calculateTotalPrice({
    required double subTotal,
    required double deliveryFee,
    required double couponDiscount,
  });
}
