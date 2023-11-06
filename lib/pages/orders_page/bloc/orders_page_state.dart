part of 'orders_page_bloc.dart';

sealed class OrdersPageState extends Equatable {
  const OrdersPageState();

  @override
  List<Object> get props => [];
}

final class OrdersPageInitial extends OrdersPageState {}

class OrdersPageLoadingStatusState extends OrdersPageState {
  final bool isLoading;
  final bool isError;
  final List<OrderDetails> orders;

  OrdersPageLoadingStatusState({
    required this.isLoading,
    required this.isError,
    required this.orders,
  });

  @override
  List<Object> get props => [
        isLoading,
        isError,
        orders,
      ];
}
