import '../../../models/models.dart';
import '../../../routes/routes_config.dart';
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
  Future<Map<String, dynamic>> addOrderDetails() async {
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

      return {
        'orderId': orderDetailsRef.id,
        'totalPrice': totalPrice.toString(),
      };
    } catch (e) {
      rethrow;
    }
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

  @override
  Future<OrderDetails?> fetchOrderDetailsByOrderId({
    required String orderId,
  }) async {
    try {
      final orderDoc = await firebaseFirestore
          .collection('Users')
          .doc(userUid)
          .collection('Orders')
          .doc(orderId)
          .get();

      print(orderDoc);

      if (orderDoc.exists) {
        final data = orderDoc.data() as Map<String, dynamic>;
        return OrderDetails.fromDocument(data);
      }
    } catch (e) {
      print('Error fetching order details: $e');
    }

    return null;
  }

  @override
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

  @override
  double calculateTotalPrice({
    required double subTotal,
    required double deliveryFee,
    required double couponDiscount,
  }) {
    double totalPrice = subTotal + deliveryFee + (-couponDiscount);
    return totalPrice;
  }

  // double calculateCouponDiscount(
  //   Coupon coupons,
  //   double subTotal,
  // ) {
  //   // Implement coupon discount calculation
  // }

  // @override
  // Future calculatePriceDetails() async {
  //   List<ShoppingCart> cartItems = await shoppingCartService.getCartItems();
  //   List<Products> products =
  //       await shoppingCartService.fetchProductsByCartItems(cartItems);

  //   double subTotal = calculateSubTotalPrice(products, cartItems);
  // }
}
