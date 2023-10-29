part of 'shopping_cart_page_bloc.dart';

sealed class ShoppingCartPageState extends Equatable {
  const ShoppingCartPageState();

  @override
  List<Object> get props => [];
}

final class ShoppingCartPageInitial extends ShoppingCartPageState {}

class ShoppingCartLoaded extends ShoppingCartPageState {
  final List<ShoppingCart> cartItems;
  final List<Products> products;
  final bool isLoading;
  final double totalPrice;

  ShoppingCartLoaded({
    required this.cartItems,
    required this.isLoading,
    required this.products,
    required this.totalPrice,
  });

  @override
  List<Object> get props => [cartItems, isLoading, products, totalPrice];
}
