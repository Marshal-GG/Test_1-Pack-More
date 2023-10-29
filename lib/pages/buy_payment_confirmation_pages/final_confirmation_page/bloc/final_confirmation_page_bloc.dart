import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'final_confirmation_page_event.dart';
part 'final_confirmation_page_state.dart';

class FinalConfirmationPageBloc extends Bloc<FinalConfirmationPageEvent, FinalConfirmationPageState> {
  FinalConfirmationPageBloc() : super(FinalConfirmationPageInitial()) {
    on<FinalConfirmationPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
