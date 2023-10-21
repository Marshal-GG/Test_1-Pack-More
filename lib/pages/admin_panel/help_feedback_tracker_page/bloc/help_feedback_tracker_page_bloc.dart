import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'help_feedback_tracker_page_event.dart';
part 'help_feedback_tracker_page_state.dart';

class HelpFeedbackTrackerPageBloc extends Bloc<HelpFeedbackTrackerPageEvent, HelpFeedbackTrackerPageState> {
  HelpFeedbackTrackerPageBloc() : super(HelpFeedbackTrackerPageInitial()) {
    on<HelpFeedbackTrackerPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
