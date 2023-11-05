part of 'check_out_page_bloc.dart';

sealed class CheckoutPageState extends Equatable {
  const CheckoutPageState();

  @override
  List<Object?> get props => [];
}

class CheckOutPageInitial extends CheckoutPageState {}

final class CheckOutPageLoadingStatus extends CheckoutPageState {
  final bool isLoading;
  final bool isError;

  CheckOutPageLoadingStatus({
    required this.isLoading,
    required this.isError,
  });

  @override
  List<Object?> get props => [
        isLoading,
        isError,
      ];
}

class CheckOutPageSubmitted extends CheckoutPageState {}
