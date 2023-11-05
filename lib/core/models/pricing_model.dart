import 'package:equatable/equatable.dart';

class Pricing extends Equatable {
  final Map<String, Coupon> coupons;
  final DeliveryCharges deliveryCharges;

  Pricing({
    required this.coupons,
    required this.deliveryCharges,
  });

  Pricing copyWith({
    Map<String, Coupon>? coupons,
    DeliveryCharges? deliveryCharges,
  }) {
    return Pricing(
      coupons: coupons ?? this.coupons,
      deliveryCharges: deliveryCharges ?? this.deliveryCharges,
    );
  }

  static Pricing fromDocument(Map<String, dynamic> data) {
    final Map<String, dynamic> couponsData = data['coupons'];
    final Map<String, Coupon> coupons = couponsData.map((key, value) {
      return MapEntry(key, Coupon.fromDocument(value));
    });

    final Map<String, dynamic> deliveryChargesData = data['deliveryCharges'];
    final DeliveryCharges deliveryCharges =
        DeliveryCharges.fromDocument(deliveryChargesData);

    return Pricing(coupons: coupons, deliveryCharges: deliveryCharges);
  }

  Map<String, dynamic> toDocument() {
    final Map<String, dynamic> couponsData = coupons.map((key, value) {
      return MapEntry(key, value.toDocument());
    });

    final Map<String, dynamic> deliveryChargesData =
        deliveryCharges.toDocument();

    return {
      'coupons': couponsData,
      'deliveryCharges': deliveryChargesData,
    };
  }

  @override
  List<Object?> get props => [
        coupons,
        deliveryCharges,
      ];
}

class Coupon extends Equatable {
  final DateTime creationDate;
  final double discount;
  final DateTime expirationDate;

  Coupon({
    required this.creationDate,
    required this.discount,
    required this.expirationDate,
  });

  Coupon copyWith({
    DateTime? creationDate,
    double? discount,
    DateTime? expirationDate,
  }) {
    return Coupon(
      creationDate: creationDate ?? this.creationDate,
      discount: discount ?? this.discount,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  static Coupon fromDocument(Map<String, dynamic> data) {
    return Coupon(
      creationDate: data['creationDate'],
      discount: data['discount'],
      expirationDate: data['expirationDate'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'creationDate': creationDate,
      'discount': discount,
      'expirationDate': expirationDate,
    };
  }

  @override
  List<Object?> get props => [creationDate, discount, expirationDate];
}

class DeliveryCharges extends Equatable {
  final double express;
  final double standard;

  DeliveryCharges({
    required this.express,
    required this.standard,
  });

  DeliveryCharges copyWith({
    double? express,
    double? standard,
  }) {
    return DeliveryCharges(
      express: express ?? this.express,
      standard: standard ?? this.standard,
    );
  }

  static DeliveryCharges fromDocument(Map<String, dynamic> data) {
    return DeliveryCharges(
      express: data['express'],
      standard: data['standard'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'express': express,
      'standard': standard,
    };
  }

  @override
  List<Object?> get props => [
        express,
        standard,
      ];
}
