part of 'check_out_page_bloc.dart';

sealed class CheckoutPageEvent extends Equatable {
  const CheckoutPageEvent();

  @override
  List<Object?> get props => [];
}

class ConfirmCheckout extends CheckoutPageEvent {}
