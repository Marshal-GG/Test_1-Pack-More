import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/firebase/services/shopping_cart_services.dart';
import '../../../core/models/product_model.dart';
import '../../../core/models/shopping_cart_model.dart';

part 'shopping_cart_page_event.dart';
part 'shopping_cart_page_state.dart';

class ShoppingCartPageBloc
    extends Bloc<ShoppingCartPageEvent, ShoppingCartPageState> {
  final ShoppingCartService shoppingCartService = ShoppingCartService();
  List<ShoppingCart> cartItems = [];
  List<Products> products = [];
  bool isLoading = false;
  double totalPrice = 0;

  ShoppingCartPageBloc() : super(ShoppingCartPageInitial()) {
    on<LoadShoppingCart>((event, emit) async {
      if (!isLoading) {
        isLoading = true;

        cartItems = await shoppingCartService.getCartItems();
        products =
            await shoppingCartService.fetchProductsByCartItems(cartItems);

        totalPrice = calculateTotalPrice(products, cartItems);
        print(totalPrice);

        emit(ShoppingCartLoaded(
          cartItems: cartItems,
          isLoading: isLoading,
          products: products,
          totalPrice: totalPrice,
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

        totalPrice = calculateTotalPrice(products, cartItems);
        print(totalPrice);

        emit(ShoppingCartLoaded(
          cartItems: cartItems,
          isLoading: isLoading,
          products: products,
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

        // totalPrice = calculateTotalPrice(products, cartItems);

        emit(ShoppingCartLoaded(
          cartItems: cartItems,
          isLoading: isLoading,
          products: products,
          totalPrice: totalPrice,
        ));

        isLoading = false;
      } else {
        emit(ShoppingCartLoaded(
          cartItems: cartItems,
          isLoading: isLoading,
          products: products,
          totalPrice: totalPrice,
        ));
      }
    });
  }

  double calculateTotalPrice(
      List<Products> products, List<ShoppingCart> cartItems) {
    double total = 0;
    for (var cartItem in cartItems) {
      final product =
          products.firstWhere((prod) => prod.productID == cartItem.productID);
      total += product.price * cartItem.quantity;
    }
    return total;
  }
}
