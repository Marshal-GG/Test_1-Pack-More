import 'package:equatable/equatable.dart';

class ShoppingCart extends Equatable {
  final String productID;
  final int quantity;

  ShoppingCart({
    required this.productID,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productID, quantity];
}
