class OrderDetails {
  final String orderId;
  final List<OrderProduct> products;
  final String userUid;
  final double totalPrice;
  final String status;
  final String paymentId;

  OrderDetails({
    required this.orderId,
    required this.products,
    required this.userUid,
    required this.totalPrice,
    required this.status,
    required this.paymentId,
  });
}

class OrderProduct {
  final String productId;
  final int quantity;

  OrderProduct({
    required this.productId,
    required this.quantity,
  });
}
