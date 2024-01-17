import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hue_dada/auth/model/auth_errors.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, clearEmailError: true));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, clearPasswordError: true));
  }

  void toggleObscurePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void checkForm() {
    AuthErrors? emailError, passwordError;
    if (state.email.isEmpty) {
      emailError = AuthErrors.emptyEmail;
    }
    if (state.password.isEmpty) {
      passwordError = AuthErrors.emptyPassword;
    }
    emit(
      state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
        status: emailError == null && passwordError == null
            ? LoginStateStatus.requestLogin
            : LoginStateStatus.formInvalid,
      ),
    );
    emit(state.copyWith(status: LoginStateStatus.initial));
  }
}
