import '../../../models/models.dart';

abstract class BaseShippingAddressRepository {
  Future<void> updateShippingAddress(String userUid, ShippingAddress address);
  Future<ShippingAddress> fetchShippingAddress(String userUid);
}
