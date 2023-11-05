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
  final double subTotal;
  final double deliveryFee;
  final double couponDiscount;
  final bool isCouponValid;
  final String couponCode;

  ShoppingCartLoaded({
    required this.subTotal,
    required this.deliveryFee,
    required this.couponDiscount,
    required this.cartItems,
    required this.isLoading,
    required this.products,
    required this.totalPrice,
    required this.isCouponValid,
    required this.couponCode,
  });

  @override
  List<Object> get props => [
        subTotal,
        deliveryFee,
        couponDiscount,
        cartItems,
        isLoading,
        products,
        totalPrice,
        isCouponValid,
        couponCode,
      ];

  ShoppingCartLoaded copyWith({
    double? subTotal,
    double? deliveryFee,
    double? couponDiscount,
    List<ShoppingCart>? cartItems,
    bool? isLoading,
    List<Products>? products,
    double? totalPrice,
    bool? isCouponValid,
    String? couponCode,
  }) {
    return ShoppingCartLoaded(
      subTotal: subTotal ?? this.subTotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
      isCouponValid: isCouponValid ?? this.isCouponValid,
      couponCode: couponCode ?? this.couponCode,
    );
  }
}
