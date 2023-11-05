import 'package:equatable/equatable.dart';
import 'package:test_1/core/models/models.dart';

class Checkout extends Equatable {
  final String name;
  final String email;
  final String contactNumber;
  final String address;
  final String city;
  final String state;
  final String zipcode;
  final List<Products> products;
  final String subtotal;
  final String deliveryFee;
  final String total;
  final String coupon;
  final String couponDiscount;

  Checkout({
    required this.name,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.products,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.coupon,
    required this.couponDiscount,
  });

  Map<String, Object> toDocument() {
    final Map<String, Object> shippingAddress = {
      'address': address,
      'city': city,
      'state': state,
      'zipcode': zipcode,
    };
    return {
      'shippingAddress': shippingAddress,
      'name': name,
      'email': email,
      'contactNumber': contactNumber,
      'products': products.map((product) => product.toDocument()).toList(),
      'coupon': coupon,
      'couponDiscount': couponDiscount,
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
    };
  }

  static Checkout? fromDocument(Map<String, dynamic> data) {
    try {
      final Map<String, dynamic> shippingAddress =
          data['shippingAddress'] as Map<String, dynamic>;

      final List<dynamic> productDocuments = data['products'] as List<dynamic>;

      // Convert product documents to a list of Products objects
      final List<Products> products = productDocuments
          .map((productDocument) => Products.fromDocument(productDocument))
          .toList();

      return Checkout(
        name: data['name'] as String,
        email: data['email'] as String,
        contactNumber: data['contactNumber'] as String,
        address: shippingAddress['address'] as String,
        city: shippingAddress['city'] as String,
        state: shippingAddress['state'] as String,
        zipcode: shippingAddress['zipcode'] as String,
        products: products,
        subtotal: data['subtotal'] as String,
        deliveryFee: data['deliveryFee'] as String,
        total: data['total'] as String,
        coupon: data['coupon'] as String,
        couponDiscount: data['couponDiscount'] as String,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  List<Object?> get props => [
        name,
        email,
        contactNumber,
        address,
        city,
        state,
        zipcode,
        products,
        subtotal,
        deliveryFee,
        total,
        coupon,
        couponDiscount,
      ];
}
