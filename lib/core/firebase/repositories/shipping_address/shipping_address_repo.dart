import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/models.dart';
import 'base_shipping_address_repo.dart';

class ShippingAddressRepository extends BaseShippingAddressRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<ShippingAddress> fetchShippingAddress(String userUid) async {
    try {
      DocumentSnapshot shippingAddressDoc = await _firestore
          .collection('Users')
          .doc(userUid)
          .collection('Details')
          .doc('Shipping Address')
          .get();

      if (shippingAddressDoc.exists) {
        Map<String, dynamic> data =
            shippingAddressDoc.data() as Map<String, dynamic>;
        return ShippingAddress.fromDocument(data);
      } else {
        return ShippingAddress(
          name: '',
          email: '',
          phone: '',
          address: '',
          city: '',
          state: '',
          pincode: '',
        );
      }
    } catch (e) {
      print("Error fetching shipping address: $e");
      rethrow;
    }
  }

  @override
  Future<void> updateShippingAddress(
    String userUid,
    ShippingAddress address,
  ) async {
    try {
      final Map<String, dynamic> addressData = address.toDocument();
      await _firestore
          .collection('Users')
          .doc(userUid)
          .collection('Details')
          .doc('Shipping Address')
          .set(addressData);
    } catch (e) {
      print("Error updating shipping address: $e");
      rethrow;
    }
  }
}
