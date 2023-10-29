part of 'payment_page_bloc.dart';

sealed class PaymentPageState extends Equatable {
  const PaymentPageState();
  
  @override
  List<Object> get props => [];
}

final class PaymentPageInitial extends PaymentPageState {}
