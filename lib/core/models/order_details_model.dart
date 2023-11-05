import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:test_1/core/models/models.dart';

class OrderDetails extends Equatable {
  final ShippingAddress shippingAddress;
  final List<Products> products;
  final String subtotal;
  final String deliveryFee;
  final String total;
  final String coupon;
  final String couponDiscount;
  final String userUid;
  final String paymentId;
  final String status;
  final String orderId;
  final Timestamp timestamp;

  OrderDetails({
    required this.shippingAddress,
    required this.products,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.coupon,
    required this.couponDiscount,
    required this.userUid,
    required this.paymentId,
    required this.status,
    required this.orderId,
    required this.timestamp,
  });

  OrderDetails copyWith({
    ShippingAddress? shippingAddress,
    List<Products>? products,
    String? subtotal,
    String? deliveryFee,
    String? total,
    String? coupon,
    String? couponDiscount,
    String? userUid,
    String? paymentId,
    String? status,
    String? orderId,
    Timestamp? timestamp,
  }) {
    return OrderDetails(
      shippingAddress: shippingAddress ?? this.shippingAddress,
      products: products ?? this.products,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      coupon: coupon ?? this.coupon,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      userUid: userUid ?? this.userUid,
      paymentId: paymentId ?? this.paymentId,
      status: status ?? this.status,
      orderId: orderId ?? this.orderId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  static OrderDetails fromDocument(data) {
    final List<dynamic> productsData = data['products'];
    final List<Products> products = productsData
        .map((productData) => Products.fromDocument(productData))
        .toList();

    final ShippingAddress shippingAddress =
        ShippingAddress.fromDocument(data['shippingAddress']);

    return OrderDetails(
      shippingAddress: shippingAddress,
      products: products,
      subtotal: data['subtotal'],
      deliveryFee: data['deliveryFee'],
      total: data['total'],
      coupon: data['coupon'],
      couponDiscount: data['couponDiscount'],
      userUid: data['userUid'],
      paymentId: data['paymentId'],
      status: data['status'],
      orderId: data['orderId'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'shippingAddress': shippingAddress.toDocument(),
      'products': products.map((product) => product.toDocument()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
      'coupon': coupon,
      'couponDiscount': couponDiscount,
      'userUid': userUid,
      'paymentId': paymentId,
      'status': status,
      'orderId': orderId,
      'timestamp': timestamp,
    };
  }

  @override
  List<Object?> get props => [
        products,
        shippingAddress,
        subtotal,
        deliveryFee,
        total,
        coupon,
        couponDiscount,
        userUid,
        paymentId,
        status,
        orderId,
        timestamp,
      ];
}
