import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/firebase/services/admin_services.dart';
import '../../../../core/models/help_feedback_model.dart';

part 'help_feedback_tracker_page_event.dart';
part 'help_feedback_tracker_page_state.dart';

class HelpFeedbackTrackerPageBloc
    extends Bloc<HelpFeedbackTrackerPageEvent, HelpFeedbackTrackerPageState> {
  final HelpFeedbackServices helpFeedbackServices;
  bool isLoading = false;
  List<HelpFeedback> helpFeedbackList = [];

  HelpFeedbackTrackerPageBloc({required this.helpFeedbackServices})
      : super(HelpFeedbackTrackerPageInitial()) {
    on<FetchNewHelpFeedbackEvent>(_fetchNewHelpFeedback);
    on<FetchOnHoldHelpFeedbackEvent>(_fetchOnHoldHelpFeedback);
    on<FetchSolvedFeedbackEvent>(_fetchSolvedFeedback);
    on<FetchRejectedFeedbackEvent>(_fetchRejectedFeedback);
  }

  void _fetchHelpFeedbackByStatus(event, emit, String status,
      Function fetchFunction, String eventType) async {
    if (!isLoading) {
      isLoading = true;

      emit(HelpFeedbackTrackerLoadingState(
        helpFeedbackList: helpFeedbackList,
        status: status,
        isLoading: isLoading,
      ));

      helpFeedbackList = await fetchFunction();

      isLoading = false;
      emit(HelpFeedbackTrackerLoadingState(
        helpFeedbackList: helpFeedbackList,
        status: status,
        isLoading: isLoading,
      ));
    }
  }

  void _fetchNewHelpFeedback(event, emit) {
    _fetchHelpFeedbackByStatus(event, emit, 'Under Review',
        helpFeedbackServices.fetchNewHelpFeedbackData, event);
  }

  void _fetchOnHoldHelpFeedback(event, emit) {
    _fetchHelpFeedbackByStatus(event, emit, 'on hold',
        helpFeedbackServices.fetchOnHoldHelpFeedbackData, event);
  }

  void _fetchSolvedFeedback(event, emit) {
    _fetchHelpFeedbackByStatus(event, emit, 'solved',
        helpFeedbackServices.fetchSolvedFeedbackData, event);
  }

  void _fetchRejectedFeedback(event, emit) {
    _fetchHelpFeedbackByStatus(event, emit, 'rejected',
        helpFeedbackServices.fetchRejectedFeedbackData, event);
  }
}
