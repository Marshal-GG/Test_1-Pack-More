import '../../../core/firebase/repositories/login_setup/login_setup_repo.dart';
import '../../../core/routes/routes_config.dart';

part 'login_setup_event.dart';
part 'login_setup_state.dart';

class LoginSetupBloc extends Bloc<LoginSetupEvent, LoginSetupState> {
  final LoginSetupRepository loginSetupRepository = LoginSetupRepository();

  bool isLoading = false;
  bool isError = false;

  LoginSetupBloc() : super(LoginSetupInitial()) {
    on<LoginSubmitEvent>((event, emit) async {
      if (!isLoading) {
        isLoading = true;
        emit(LoginPageSubmitState(
          isError: isError,
          isLoading: isLoading,
        ));

        try {
          await loginSetupRepository.login(
            email: event.email,
            password: event.password,
          );
        } catch (e) {
          isError = true;
          Fluttertoast.showToast(
            msg: 'Failed to Login: $e',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }

        isLoading = false;
        emit(LoginPageSubmitState(
          isError: isError,
          isLoading: isLoading,
        ));
        isError = false;
        emit(LoginSetupInitial());
      }
    });
  }
}
