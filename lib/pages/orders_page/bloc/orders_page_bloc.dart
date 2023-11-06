import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_1/core/models/models.dart';

import '../../../core/firebase/repositories/order_details/order_details_repo.dart';

part 'orders_page_event.dart';
part 'orders_page_state.dart';

class OrdersPageBloc extends Bloc<OrdersPageEvent, OrdersPageState> {
  final OrderDetailsRepository orderDetailsRepository =
      OrderDetailsRepository();

  bool isLoading = false;
  bool isError = false;

  List<OrderDetails> orderDetails = [];

  OrdersPageBloc() : super(OrdersPageInitial()) {
    on<LoadOrdersPageEvent>((event, emit) async {
      if (!isLoading) {
        isLoading = true;
        // try {
        orderDetails = await orderDetailsRepository.fetchAllOrderDetails();
        // } catch (e) {
        //   isError = true;
        //   print('Error fetching orders details: $e');
        // }
        isLoading = false;
        emit(OrdersPageLoadingStatusState(
          orders: orderDetails,
          isLoading: isLoading,
          isError: isError,
        ));
        isError = false;
      }
    });
  }
}
