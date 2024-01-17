part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.emailError,
    this.password = '',
    this.obscurePassword = true,
    this.passwordError,
    this.status = LoginStateStatus.initial,
  });

  final String email;
  final AuthErrors? emailError;
  final String password;
  final AuthErrors? passwordError;
  final bool obscurePassword;
  final LoginStateStatus status;

  LoginState copyWith({
    String? email,
    AuthErrors? emailError,
    String? password,
    AuthErrors? passwordError,
    bool? obscurePassword,
    LoginStateStatus? status,
    bool clearEmailError = false,
    bool clearPasswordError = false,
  }) {
    return LoginState(
      email: email ?? this.email,
      emailError: clearEmailError ? null : emailError ?? this.emailError,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      passwordError:
          clearPasswordError ? null : passwordError ?? this.passwordError,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        email,
        emailError,
        password,
        obscurePassword,
        passwordError,
        status,
      ];
}

enum LoginStateStatus {
  initial,
  formInvalid,
  requestLogin,
}
