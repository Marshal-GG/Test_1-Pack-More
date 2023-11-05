import 'package:test_1/core/models/models.dart';

abstract class BaseOrderDetailsRepository {
  Future<void> addOrderDetails();
  Future<List<OrderDetails>> fetchAllOrderDetails();
}
