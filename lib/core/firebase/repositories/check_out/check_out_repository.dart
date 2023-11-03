import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/models.dart';
import 'base_check_out_repo.dart';

class CheckoutRepository extends BaseCheckoutRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String userUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<void> addCheckout(Checkout checkout) {
    return _firebaseFirestore
        .collection('Users')
        .doc(userUid)
        .collection('checkout')
        .add(checkout.toDocument());
  }

  Future<Checkout?> fetchCheckout(String checkoutId) async {
    final DocumentSnapshot document = await _firebaseFirestore
        .collection('Users')
        .doc(userUid)
        .collection('checkout')
        .doc(checkoutId)
        .get();

    if (document.exists) {
      return Checkout.fromDocument(document.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}

// class CheckoutRepository {
//   final CollectionReference _checkoutCollection =
//       FirebaseFirestore.instance.collection('checkouts');

//   Future<void> saveCheckout(Checkout checkout) async {
//     await _checkoutCollection.add(checkout.toDocument());
//   }

//   Future<Checkout?> fetchCheckout(String checkoutId) async {
//     final DocumentSnapshot document =
//         await _checkoutCollection.doc(checkoutId).get();

//     if (document.exists) {
//       return Checkout.fromDocument(document.data() as Map<String, dynamic>);
//     } else {
//       return null;
//     }
//   }
// }
