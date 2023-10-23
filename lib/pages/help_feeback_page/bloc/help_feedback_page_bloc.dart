import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_1/core/firebase/services/help_feedback_services.dart';

part 'help_feedback_page_event.dart';
part 'help_feedback_page_state.dart';

class HelpFeedbackPageBloc
    extends Bloc<HelpFeedbackPageEvent, HelpFeedbackPageState> {
  final HelpFeedbackService helpFeedbackService;
  bool isUploading = false;
  bool isError = false;

  HelpFeedbackPageBloc({
    required this.helpFeedbackService,
  }) : super(HelpFeedbackPageInitial()) {
    on<HelpFeedbackSubmitEvent>((event, emit) async {
      if (!isUploading) {
        isUploading = true;
        emit(HelpFeedbackPageLoadingStatusState(
            isUploading: isUploading, isError: isError));

        try {
          await helpFeedbackService.addHelpFeedback(
            type: event.type,
            message: event.message,
            selectedImages: event.selectedImages,
          );

          emit(HelpFeedbackSubmitted());
        } catch (e) {
          isError = true;
          emit(HelpFeedbackPageLoadingStatusState(
            isUploading: isUploading,
            isError: isError,
          ));
        }

        isUploading = false;

        emit(HelpFeedbackPageLoadingStatusState(
          isUploading: isUploading,
          isError: isError,
        ));

        isError = false;
      }
    });
  }
}
