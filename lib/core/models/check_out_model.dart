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
  });

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
      ];

  Map<String, Object> toDocument() {
    final Map<String, Object> custAddress = {
      'address': address,
      'city': city,
      'state': state,
      'zipcode': zipcode,
    };
    return {
      'custAddress': custAddress,
      'custName': name,
      'custEmail': email,
      'custContactNumber': contactNumber,
      'products': products.map((product) => product.toDocument()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
    };
  }

  static Checkout? fromDocument(Map<String, dynamic> data) {
    try {
      final Map<String, dynamic> custAddress =
          data['custAddress'] as Map<String, dynamic>;
      final List<dynamic> productDocuments = data['products'] as List<dynamic>;

      // Convert product documents to a list of Products objects
      final List<Products> products = productDocuments
          .map((productDocument) => Products.fromDocument(productDocument))
          .toList();

      return Checkout(
        name: data['custName'] as String,
        email: data['custEmail'] as String,
        contactNumber: data['custContactNumber'] as String,
        address: custAddress['address'] as String,
        city: custAddress['city'] as String,
        state: custAddress['state'] as String,
        zipcode: custAddress['zipcode'] as String,
        products: products,
        subtotal: data['subtotal'] as String,
        deliveryFee: data['deliveryFee'] as String,
        total: data['total'] as String,
      );
    } catch (e) {
      return null;
    }
  }
}
