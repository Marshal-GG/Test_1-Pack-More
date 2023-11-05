import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/firebase/repositories/order_details/order_details_repo.dart';
import '../../../core/firebase/services/shopping_cart_services.dart';
import '../../../core/models/product_model.dart';
import '../../../core/models/shopping_cart_model.dart';

part 'shopping_cart_page_event.dart';
part 'shopping_cart_page_state.dart';

class ShoppingCartPageBloc
    extends Bloc<ShoppingCartPageEvent, ShoppingCartPageState> {
  final ShoppingCartService shoppingCartService = ShoppingCartService();
  final OrderDetailsRepository orderDetailsRepository =
      OrderDetailsRepository();

  List<ShoppingCart> cartItems = [];
  List<Products> products = [];
  bool isLoading = false;
  bool isCouponValid = false;
  double totalPrice = 0;
  double subTotal = 0;
  String couponCode = '';
  double deliveryFee = 40;
  double couponDiscount = 0;

  ShoppingCartPageBloc() : super(ShoppingCartPageInitial()) {
    on<LoadShoppingCart>((event, emit) async {
      if (!isLoading) {
        isLoading = true;

        cartItems = await shoppingCartService.getCartItems();
        products =
            await shoppingCartService.fetchProductsByCartItems(cartItems);

        subTotal = await orderDetailsRepository.calculateSubTotalPrice();

        totalPrice = orderDetailsRepository.calculateTotalPrice(
          subTotal: subTotal,
          deliveryFee: deliveryFee,
          couponDiscount: couponDiscount,
        );

        emit(ShoppingCartLoaded(
          cartItems: cartItems,
          isLoading: isLoading,
          products: products,
          totalPrice: totalPrice,
          isCouponValid: isCouponValid,
          couponCode: couponCode,
          couponDiscount: couponDiscount,
          deliveryFee: deliveryFee,
          subTotal: subTotal,
        ));

        isLoading = false;
      }
    });

    on<RemoveFromCart>((event, emit) async {
      if (!isLoading) {
        isLoading = true;

        shoppingCartService.removeFromCart(event.product);
        products.remove(event.product);
        cartItems.removeWhere(
            (cartItem) => cartItem.productID == event.product.productID);

        subTotal = await orderDetailsRepository.calculateSubTotalPrice();
        totalPrice = orderDetailsRepository.calculateTotalPrice(
          subTotal: subTotal,
          deliveryFee: deliveryFee,
          couponDiscount: couponDiscount,
        );

        emit((state as ShoppingCartLoaded).copyWith(
          cartItems: cartItems,
          products: products,
          isLoading: isLoading,
          subTotal: subTotal,
          totalPrice: totalPrice,
        ));

        isLoading = false;
      }
    });

    on<UpdateCartProductQuantity>((event, emit) async {
      if (!isLoading && event.quantity >= 1) {
        isLoading = true;

        await shoppingCartService.updateCartProductQuantity(
            event.product.productID, event.quantity);
        cartItems = await shoppingCartService.getCartItems();

        subTotal = await orderDetailsRepository.calculateSubTotalPrice();
        totalPrice = orderDetailsRepository.calculateTotalPrice(
          subTotal: subTotal,
          deliveryFee: deliveryFee,
          couponDiscount: couponDiscount,
        );
        emit((state as ShoppingCartLoaded).copyWith(
          cartItems: cartItems,
          isLoading: isLoading,
          totalPrice: totalPrice,
          subTotal: subTotal,
        ));

        isLoading = false;
      } else {
        emit((state as ShoppingCartLoaded).copyWith(
          cartItems: cartItems,
          isLoading: isLoading,
          totalPrice: totalPrice,
          subTotal: subTotal,
        ));
      }
    });

    on<VerifyCouponEvent>((event, emit) async {
      if (!isLoading) {
        isLoading = true;

        try {
          isCouponValid =
              await shoppingCartService.verifyCoupon(event.couponCode);
          couponCode = event.couponCode.toUpperCase();

          isLoading = false;
          emit((state as ShoppingCartLoaded).copyWith(
            isLoading: isLoading,
            isCouponValid: isCouponValid,
            couponCode: couponCode,
          ));
        } catch (e) {
          isLoading = false;
          emit((state as ShoppingCartLoaded).copyWith(
            isLoading: isLoading,
            isCouponValid: isCouponValid,
            couponCode: couponCode,
          ));
        }

        isLoading = false;
      }
    });
  }
}
