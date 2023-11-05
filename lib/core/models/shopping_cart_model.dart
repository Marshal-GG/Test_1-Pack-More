import 'package:equatable/equatable.dart';

class ShoppingCart extends Equatable {
  final String productID;
  final int quantity;
  final String price;

  ShoppingCart({
    required this.productID,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [productID, quantity, price];

  ShoppingCart copyWith({
    String? productID,
    int? quantity,
    String? price,
  }) {
    return ShoppingCart(
      productID: productID ?? this.productID,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  double getSubtotal() {
    return quantity * double.parse(price);
  }

  double getTotal() {
    return getSubtotal() + 1;
  }
}

class ShoppingCartDetails extends Equatable {
  final String couponCode;
  final String couponDiscount;
  final String deliveryFee;
  final String subtotal;
  final String total;

  ShoppingCartDetails({
    required this.couponCode,
    required this.couponDiscount,
    required this.deliveryFee,
    required this.subtotal,
    required this.total,
  });

  ShoppingCartDetails copyWith({
    String? couponCode,
    String? couponDiscount,
    String? deliveryFee,
    String? subtotal,
    String? total,
  }) {
    return ShoppingCartDetails(
      couponCode: couponCode ?? this.couponCode,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
    );
  }

  static ShoppingCartDetails fromMap(Map<String, dynamic> map) {
    return ShoppingCartDetails(
      couponCode: map['couponCode'] ?? '',
      couponDiscount: map['couponDiscount'] ?? '',
      deliveryFee: map['deliveryFee'] ?? '',
      subtotal: map['subtotal'] ?? '',
      total: map['total'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'couponCode': couponCode,
      'couponDiscount': couponDiscount,
      'deliveryFee': deliveryFee,
      'subtotal': subtotal,
      'total': total,
    };
  }

  @override
  List<Object?> get props => [
        couponCode,
        couponDiscount,
        deliveryFee,
        subtotal,
        total,
      ];
}
