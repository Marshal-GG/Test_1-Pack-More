part of 'shopping_cart_page_bloc.dart';

sealed class ShoppingCartPageEvent extends Equatable {
  const ShoppingCartPageEvent();

  @override
  List<Object> get props => [];
}

class LoadShoppingCart extends ShoppingCartPageEvent {}

class UpdateCartProductQuantity extends ShoppingCartPageEvent {
  final Products product;
  final int quantity;

  UpdateCartProductQuantity({required this.product, required this.quantity});

  @override
  List<Object> get props => [product, quantity];
}

class RemoveFromCart extends ShoppingCartPageEvent {
  final Products product;

  RemoveFromCart({required this.product});

  @override
  List<Object> get props => [product];
}
