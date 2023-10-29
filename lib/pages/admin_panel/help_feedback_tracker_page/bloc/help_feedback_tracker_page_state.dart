part of 'help_feedback_tracker_page_bloc.dart';

sealed class HelpFeedbackTrackerPageState extends Equatable {
  const HelpFeedbackTrackerPageState();

  @override
  List<Object> get props => [];
}

final class HelpFeedbackTrackerPageInitial
    extends HelpFeedbackTrackerPageState {}

class HelpFeedbackTrackerLoadingState extends HelpFeedbackTrackerPageState {
  final List<HelpFeedback> helpFeedbackList;
  final String status;
  final bool isLoading;

  HelpFeedbackTrackerLoadingState({
    required this.helpFeedbackList,
    required this.status,
    required this.isLoading,
  });

  @override
  List<Object> get props => [helpFeedbackList, status, isLoading];
}
