part of 'login_setup_bloc.dart';

sealed class LoginSetupEvent extends Equatable {
  const LoginSetupEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitEvent extends LoginSetupEvent {
  final String email;
  final String password;

  LoginSubmitEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}
