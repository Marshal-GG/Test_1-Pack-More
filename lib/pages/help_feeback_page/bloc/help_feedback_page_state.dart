part of 'help_feedback_page_bloc.dart';

sealed class HelpFeedbackPageState extends Equatable {
  const HelpFeedbackPageState();

  @override
  List<Object> get props => [];
}

final class HelpFeedbackPageInitial extends HelpFeedbackPageState {}

class HelpFeedbackSubmitted extends HelpFeedbackPageState {}

class HelpFeedbackPageLoadingStatusState extends HelpFeedbackPageState {
  final bool isUploading;
  final bool isError;

  HelpFeedbackPageLoadingStatusState({
    required this.isUploading,
    required this.isError,
  });
  @override
  List<Object> get props => [isUploading, isError];
}
