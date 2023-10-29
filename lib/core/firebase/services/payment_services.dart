import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/payment_model.dart';

class PaymentService {
  List<Payment> _payments = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPayment({required Payment payment}) async {
    try {
      String userUid = _auth.currentUser!.uid;

      final paymentData = {
        'userUid': userUid,
        'orderId': payment.orderId,
        'amount': payment.amount,
        'paymentMethod': payment.paymentMethod,
        'timestamp': payment.timestamp,
      };

      final paymentRef =
          await _firestore.collection('payments').add(paymentData);
      final paymentId = paymentRef.id;

      payment = Payment(
        paymentId: paymentId,
        userUid: userUid,
        orderId: payment.orderId,
        amount: payment.amount,
        paymentMethod: payment.paymentMethod,
        timestamp: payment.timestamp,
      );

      _payments.add(payment);
    } catch (e) {
      print("Error adding payment: $e");
    }
  }

  List<Payment> getAllPayments() {
    return _payments;
  }

  List<Payment> getPaymentsByUserId(String userId) {
    return _payments.where((payment) => payment.userUid == userId).toList();
  }

  List<Payment> getPaymentsByOrderId(String orderId) {
    return _payments.where((payment) => payment.orderId == orderId).toList();
  }

  double getTotalAmountForUser(String userId) {
    final userPayments = getPaymentsByUserId(userId);
    return userPayments.fold(0.0, (total, payment) => total + payment.amount);
  }

  void updatePayment(String paymentId, Payment updatedPayment) {
    final index =
        _payments.indexWhere((payment) => payment.paymentId == paymentId);
    if (index != -1) {
      _payments[index] = updatedPayment;
    }
  }

  void deletePayment(String paymentId) {
    _payments.removeWhere((payment) => payment.paymentId == paymentId);
  }
}
