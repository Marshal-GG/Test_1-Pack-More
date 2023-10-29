import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'review_order_page_event.dart';
part 'review_order_page_state.dart';

class ReviewOrderPageBloc extends Bloc<ReviewOrderPageEvent, ReviewOrderPageState> {
  ReviewOrderPageBloc() : super(ReviewOrderPageInitial()) {
    on<ReviewOrderPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
