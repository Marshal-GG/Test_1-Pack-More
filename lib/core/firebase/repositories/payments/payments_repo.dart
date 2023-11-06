import 'package:test_1/core/models/models.dart';

import '../../../routes/routes_config.dart';
import '../order_details/order_details_repo.dart';
import 'base_payments_repo.dart';

class PaymentsRepository extends BasePaymentsRepository {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String userUid = FirebaseAuth.instance.currentUser!.uid;
  final OrderDetailsRepository orderDetailsRepository =
      OrderDetailsRepository();

  @override
  Future<void> addPayment({
    required OrderDetails orderDetails,
    required String orderId,
    required String status,
    required String paymentMethod,
    required String amount,
  }) async {
    print(orderDetails);

    Timestamp timestamp = Timestamp.now();

    Payment payment = Payment(
      paymentId: '', // done
      userUid: userUid,
      orderId: orderId,
      status: status,
      amount: amount,
      paymentMethod: paymentMethod,
      timestamp: timestamp,
    );

    final paymentDocRef = await firebaseFirestore
        .collection('payments')
        .add(payment.toDocument());

    orderDetails = orderDetails.copyWith(
      paymentId: paymentDocRef.id,
    );

    await firebaseFirestore
        .collection('Users')
        .doc(userUid)
        .collection('Orders')
        .doc(orderId)
        .update(orderDetails.toDocument());

    paymentDocRef.update({
      'paymentId': paymentDocRef.id,
    });
  }
}
