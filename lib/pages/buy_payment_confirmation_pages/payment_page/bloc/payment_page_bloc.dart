import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/firebase/repositories/order_details/order_details_repo.dart';
import '../../../../core/firebase/repositories/payments/payments_repo.dart';
import '../../../../core/models/models.dart';

part 'payment_page_event.dart';
part 'payment_page_state.dart';

class PaymentPageBloc extends Bloc<PaymentPageEvent, PaymentPageState> {
  final PaymentsRepository paymentsRepository = PaymentsRepository();
  final OrderDetailsRepository orderDetailsRepository =
      OrderDetailsRepository();

  bool isLoading = false;
  bool isError = false;

  PaymentPageBloc() : super(PaymentPageInitial()) {
    on<PaymentPageConfirmCheckoutEvent>((event, emit) async {
      if (!isLoading) {
        isLoading = true;
        emit(PaymentPageSubmittedState(
          isError: isError,
          isLoading: isLoading,
        ));

        try {
          final orderDetailsData =
              await orderDetailsRepository.addOrderDetails();
          final orderId = orderDetailsData['orderId'];
          final totalPrice = orderDetailsData['totalPrice'];

          OrderDetails? orderDetails = await orderDetailsRepository
              .fetchOrderDetailsByOrderId(orderId: orderId);
          

          await paymentsRepository.addPayment(
            orderDetails: orderDetails!,
            orderId: orderId,
            status: 'Completed',
            paymentMethod: event.paymentMethod,
            amount: totalPrice,
          );
        } catch (e) {
          isError = true;
          print('catch $e');
        }

        isLoading = false;
        emit(PaymentPageSubmittedState(
          isError: isError,
          isLoading: isLoading,
        ));
        isError = false;
      }
    });
  }
}
