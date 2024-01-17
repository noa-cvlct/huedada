part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.email = '',
    this.emailError,
    this.password = '',
    this.obscurePassword = true,
    this.passwordError,
    this.confirmPassword = '',
    this.confirmPasswordError,
    this.status = RegisterStateStatus.initial,
  });

  final String email;
  final AuthErrors? emailError;
  final String password;
  final bool obscurePassword;
  final AuthErrors? passwordError;
  final String confirmPassword;
  final AuthErrors? confirmPasswordError;
  final RegisterStateStatus status;

  RegisterState copyWith({
    String? email,
    AuthErrors? emailError,
    String? password,
    bool? obscurePassword,
    AuthErrors? passwordError,
    String? confirmPassword,
    AuthErrors? confirmPasswordError,
    RegisterStateStatus? status,
    bool clearEmailError = false,
    bool clearPasswordError = false,
    bool clearConfirmPasswordError = false,
  }) {
    return RegisterState(
      email: email ?? this.email,
      emailError: clearEmailError ? null : emailError ?? this.emailError,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      passwordError:
          clearPasswordError ? null : passwordError ?? this.passwordError,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      confirmPasswordError: clearConfirmPasswordError
          ? null
          : confirmPasswordError ?? this.confirmPasswordError,
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
        confirmPassword,
        confirmPasswordError,
        status,
      ];
}

enum RegisterStateStatus {
  initial,
  formInvalid,
  requestRegister,
}
