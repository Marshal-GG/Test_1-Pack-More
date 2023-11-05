import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/models.dart';
import '../../services/shopping_cart_services.dart';
import '../shipping_address/shipping_address_repo.dart';
import 'base_order_details_repo.dart';

class OrderDetailsRepository extends BaseOrderDetailsRepository {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String userUid = FirebaseAuth.instance.currentUser!.uid;
  final ShoppingCartService shoppingCartService = ShoppingCartService();
  final ShippingAddressRepository shippingAddressRepository =
      ShippingAddressRepository();

  @override
  Future<void> addOrderDetails() async {
    try {
      List<ShoppingCart> cartItems = await shoppingCartService.getCartItems();

      List<Products> products =
          await shoppingCartService.fetchProductsByCartItems(cartItems);

      ShippingAddress shippingAddress =
          await shippingAddressRepository.fetchShippingAddress(userUid);

      double subTotal = await calculateSubTotalPrice();
      // fetch coupon from applied doc
      String couponCode = '';
      double couponDiscount = 0;
      // calculateCouponDiscount();
      double deliveryFee = 40;
      // calculateCouponDiscount();
      double totalPrice = calculateTotalPrice(
        subTotal: subTotal,
        deliveryFee: deliveryFee,
        couponDiscount: couponDiscount,
      );

      Timestamp timestamp = Timestamp.now();

      OrderDetails orderDetails = OrderDetails(
        shippingAddress: shippingAddress,
        products: products,
        subtotal: subTotal.toString(),
        deliveryFee: deliveryFee.toString(),
        total: totalPrice.toString(),
        coupon: couponCode,
        couponDiscount: couponDiscount.toString(),
        userUid: userUid,
        paymentId: '',
        status: 'Pending',
        orderId: '', // done
        timestamp: timestamp,
      );

      final orderDetailsRef = await firebaseFirestore
          .collection('Users')
          .doc(userUid)
          .collection('Orders')
          .add(orderDetails.toDocument());

      orderDetailsRef.update({
        'orderId': orderDetailsRef.id,
      });
    } catch (e) {
      rethrow;
    }
    // return firebaseFirestore
    //     .collection('Users')
    //     .doc(userUid)
    //     .collection('orders')
    //     .add(orderDetails.toDocument());
  }

  @override
  Future<List<OrderDetails>> fetchAllOrderDetails() async {
    final querySnapshot = await firebaseFirestore
        .collection('Users')
        .doc(userUid)
        .collection('Orders')
        .get();

    final orderDetails = querySnapshot.docs
        .map((doc) => OrderDetails.fromDocument(doc))
        .toList();
    return orderDetails;
  }

  Future<double> calculateSubTotalPrice() async {
    List<ShoppingCart> cartItems = await shoppingCartService.getCartItems();

    List<Products> products =
        await shoppingCartService.fetchProductsByCartItems(cartItems);

    double total = 0;
    for (var cartItem in cartItems) {
      final product =
          products.firstWhere((prod) => prod.productID == cartItem.productID);
      total += product.price * cartItem.quantity;
    }
    return total;
  }

  // double calculateCouponDiscount(
  //   Coupon coupons,
  //   double subTotal,
  // ) {
  //   // Implement coupon discount calculation
  // }

  double calculateTotalPrice({
    required double subTotal,
    required double deliveryFee,
    required double couponDiscount,
  }) {
    double totalPrice = subTotal + deliveryFee + (-couponDiscount);
    return totalPrice;
  }

  // @override
  // Future calculatePriceDetails() async {
  //   List<ShoppingCart> cartItems = await shoppingCartService.getCartItems();
  //   List<Products> products =
  //       await shoppingCartService.fetchProductsByCartItems(cartItems);

  //   double subTotal = calculateSubTotalPrice(products, cartItems);
  // }
}
