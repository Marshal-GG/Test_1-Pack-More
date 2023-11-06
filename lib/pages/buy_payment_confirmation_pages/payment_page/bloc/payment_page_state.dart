part of 'payment_page_bloc.dart';

sealed class PaymentPageState extends Equatable {
  const PaymentPageState();

  @override
  List<Object> get props => [];
}

final class PaymentPageInitial extends PaymentPageState {}

class PaymentPageSubmittedState extends PaymentPageState {
  final bool isLoading;
  final bool isError;

  PaymentPageSubmittedState({
    required this.isLoading,
    required this.isError,
  });

  @override
  List<Object> get props => [
        isLoading,
        isError,
      ];
}
