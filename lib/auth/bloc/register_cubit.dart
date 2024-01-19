import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hue_dada/auth/model/auth_errors.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void emailChanged(String value) =>
      emit(state.copyWith(email: value, clearEmailError: true));

  void passwordChanged(String value) =>
      emit(state.copyWith(password: value, clearPasswordError: true));

  void confirmPasswordChanged(String value) => emit(state.copyWith(
        confirmPassword: value,
        clearConfirmPasswordError: true,
      ));

  void toggleObscurePassword() =>
      emit(state.copyWith(obscurePassword: !state.obscurePassword));

  void resetStatus() =>
      emit(state.copyWith(status: RegisterStateStatus.initial));

  void checkForm() {
    AuthErrors? emailError, passwordError, confirmPasswordError;
    if (state.email.isEmpty) {
      emailError = AuthErrors.emptyEmail;
    }
    if (state.password.isEmpty) {
      passwordError = AuthErrors.emptyPassword;
    }
    if (state.confirmPassword.isEmpty) {
      confirmPasswordError = AuthErrors.emptyConfirmPassword;
    }
    if (state.password != state.confirmPassword) {
      confirmPasswordError = AuthErrors.passwordsDontMatch;
    }
    emit(state.copyWith(
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      status: emailError == null &&
              passwordError == null &&
              confirmPasswordError == null
          ? RegisterStateStatus.requestRegister
          : RegisterStateStatus.formInvalid,
    ));
  }
}
