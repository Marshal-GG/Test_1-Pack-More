import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_1/core/firebase/repositories/check_out/check_out_repository.dart';

import '../../../../core/firebase/services/firebase_services.dart';
import '../../../../core/models/models.dart';

part 'check_out_page_event.dart';
part 'check_out_page_state.dart';

class CheckoutPageBloc extends Bloc<CheckoutPageEvent, CheckoutPageState> {
  final FirebaseService firebaseService = FirebaseService();
  final CheckoutRepository checkoutRepository = CheckoutRepository();
  bool isLoading = false;

  CheckoutPageBloc() : super(CheckOutPageInitial()) {
    on<UpdateCheckout>((event, emit) async {
      if (!isLoading) {
        isLoading = true;

        isLoading = false;
      }
    });

    on<ConfirmCheckout>((event, emit) async {
      if (!isLoading) {
        isLoading = true;

        isLoading = false;
      }
    });
  }
}
