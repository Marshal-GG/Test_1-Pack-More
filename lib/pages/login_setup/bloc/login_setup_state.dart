part of 'login_setup_bloc.dart';

sealed class LoginSetupState extends Equatable {
  const LoginSetupState();

  @override
  List<Object> get props => [];
}

final class LoginSetupInitial extends LoginSetupState {}

class LoginPageSubmitState extends LoginSetupState {
  final bool isLoading;
  final bool isError;

  LoginPageSubmitState({
    required this.isLoading,
    required this.isError,
  });

  LoginPageSubmitState copyWith({
    bool? isLoading,
    bool? isError,
  }) {
    return LoginPageSubmitState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isError,
      ];
}
