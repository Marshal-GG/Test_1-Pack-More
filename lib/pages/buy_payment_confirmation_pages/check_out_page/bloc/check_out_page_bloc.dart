import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/firebase/repositories/order_details/order_details_repo.dart';

part 'check_out_page_event.dart';
part 'check_out_page_state.dart';

class CheckoutPageBloc extends Bloc<CheckoutPageEvent, CheckoutPageState> {
  final OrderDetailsRepository orderDetailsRepository =
      OrderDetailsRepository();

  bool isLoading = false;
  bool isError = false;

  CheckoutPageBloc() : super(CheckOutPageInitial()) {
    on<ConfirmCheckout>((event, emit) async {
      if (!isLoading) {
        isLoading = true;
        emit(CheckOutPageLoadingStatus(isError: isError, isLoading: isLoading));

        try {
          await orderDetailsRepository.addOrderDetails();
          emit(CheckOutPageSubmitted());
        } catch (e) {
          isError = true;
          emit(CheckOutPageLoadingStatus(
              isError: isError, isLoading: isLoading));
        }

        isLoading = false;

        emit(CheckOutPageLoadingStatus(isError: isError, isLoading: isLoading));

        isError = false;
      }
    });
  }
}
