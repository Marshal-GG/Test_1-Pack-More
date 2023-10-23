part of 'help_feedback_page_bloc.dart';

sealed class HelpFeedbackPageEvent extends Equatable {
  const HelpFeedbackPageEvent();

  @override
  List<Object> get props => [];
}

class HelpFeedbackSubmitEvent extends HelpFeedbackPageEvent {
  final String type;
  final String message;
  final List<XFile> selectedImages;

  const HelpFeedbackSubmitEvent({
    required this.type,
    required this.message,
    required this.selectedImages,
  });

  @override
  List<Object> get props => [
        type,
        message,
        selectedImages,
      ];
}