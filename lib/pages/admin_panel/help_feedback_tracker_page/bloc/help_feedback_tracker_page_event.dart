part of 'help_feedback_tracker_page_bloc.dart';

sealed class HelpFeedbackTrackerPageEvent extends Equatable {
  const HelpFeedbackTrackerPageEvent();

  @override
  List<Object> get props => [];
}

class FetchNewHelpFeedbackEvent extends HelpFeedbackTrackerPageEvent {
  @override
  List<Object> get props => [];
}

class FetchOnHoldHelpFeedbackEvent extends HelpFeedbackTrackerPageEvent {
  @override
  List<Object> get props => [];
}

class FetchSolvedFeedbackEvent extends HelpFeedbackTrackerPageEvent {
  @override
  List<Object> get props => [];
}

class FetchRejectedFeedbackEvent extends HelpFeedbackTrackerPageEvent {
  @override
  List<Object> get props => [];
}
