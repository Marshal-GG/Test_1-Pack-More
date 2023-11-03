part of 'check_out_page_bloc.dart';

sealed class CheckoutPageState extends Equatable {
  const CheckoutPageState();

  @override
  List<Object?> get props => [];
}

class CheckOutPageInitial extends CheckoutPageState {}

final class CheckOutPageLoading extends CheckoutPageState {}

final class CheckOutPageLoaded extends CheckoutPageState {
  final String name;
  final String email;
  final String contactNumber;
  final String address;
  final String city;
  final String state;
  final String zipcode;
  final List<Products> products;
  final String subtotal;
  final String deliveryFee;
  final String total;
  final Checkout checkout;
  final bool isLoading;

  CheckOutPageLoaded({
    required this.name,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.products,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.isLoading,
  }) : checkout = Checkout(
          name: name,
          email: email,
          contactNumber: contactNumber,
          address: address,
          city: city,
          state: state,
          zipcode: zipcode,
          products: products,
          subtotal: subtotal,
          deliveryFee: deliveryFee,
          total: total,
        );

  @override
  List<Object?> get props => [
        name,
        email,
        contactNumber,
        address,
        city,
        state,
        zipcode,
        products,
        subtotal,
        deliveryFee,
        total,
        isLoading,
      ];
}
