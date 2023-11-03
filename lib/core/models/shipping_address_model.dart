import 'package:equatable/equatable.dart';

class ShippingAddress extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String pincode;

  ShippingAddress({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
  });

  ShippingAddress copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? pincode,
  }) {
    return ShippingAddress(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'pincode': pincode,
    };
  }

  factory ShippingAddress.fromDocument(Map<String, dynamic> doc) {
    return ShippingAddress(
      name: doc['name'] ?? '',
      email: doc['email'] ?? '',
      phone: doc['phone'] ?? '',
      address: doc['address'] ?? '',
      city: doc['city'] ?? '',
      state: doc['state'] ?? '',
      pincode: doc['pincode'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        address,
        city,
        state,
        pincode,
      ];
}
