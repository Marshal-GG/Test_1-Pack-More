part of 'payment_page_bloc.dart';

sealed class PaymentPageEvent extends Equatable {
  const PaymentPageEvent();

  @override
  List<Object> get props => [];
}

class PaymentPageConfirmCheckoutEvent extends PaymentPageEvent {
  final String paymentMethod;

  PaymentPageConfirmCheckoutEvent({
    required this.paymentMethod,
  });

  @override
  List<Object> get props => [paymentMethod];
}
