part of 'check_out_page_bloc.dart';

sealed class CheckoutPageEvent extends Equatable {
  const CheckoutPageEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCheckout extends CheckoutPageEvent {
  final String? name;
  final String? email;
  final String? contactNumber;
  final String? address;
  final String? city;
  final String? state;
  final String? zipcode;
  final ShoppingCart? shoppingCart;

  UpdateCheckout({
    this.name,
    this.email,
    this.contactNumber,
    this.address,
    this.city,
    this.state,
    this.zipcode,
    this.shoppingCart,
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
        shoppingCart,
      ];
}

class ConfirmCheckout extends CheckoutPageEvent {
  final Checkout checkout;

  ConfirmCheckout({
    required this.checkout,
  });

  @override
  List<Object?> get props => [checkout];
}
