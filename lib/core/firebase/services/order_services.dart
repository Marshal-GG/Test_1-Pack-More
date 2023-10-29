import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/order_model.dart';

class OrderService {
  List<OrderDetails> _orders = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOrder(OrderDetails order) async {
    try {
      final userUid = _auth.currentUser!.uid;

      final orderData = {
        'userUid': userUid,
        'status': order.status, // Pending
        'paymentId': order.paymentId, // Null
        'products': '', // List of selected products with how many
        'total price': '', // Calculated somewhere
      };

      final orderRef = await _firestore.collection('orders').add(orderData);
      final orderId = orderRef.id;

      _orders.add(order);
    } catch (e) {
      print("Error adding order: $e");
    }
  }

  // Retrieve a list of all orders
  List<OrderDetails> getAllOrders() {
    return _orders;
  }

  // Retrieve orders by status
  List<OrderDetails> getOrdersByStatus(String status) {
    return _orders.where((order) => order.status == status).toList();
  }

  // Retrieve orders by paymentId
  List<OrderDetails> getOrdersByPaymentId(String paymentId) {
    return _orders.where((order) => order.paymentId == paymentId).toList();
  }
}
