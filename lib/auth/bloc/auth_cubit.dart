import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hue_dada/auth/bloc/auth_state.dart';
import 'package:hue_dada/auth/model/auth_errors.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState()) {
    listenAuthChanges();
  }

  void listenAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      emit(AuthState(user: user));
    });
  }

  Future<void> register(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      emitError(e.code);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      emitError(e.code);
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  void emitError(String message) {
    AuthErrors error;
    switch (message) {
      case 'invalid-email':
        error = AuthErrors.invalidEmail;
        break;
      case 'weak-password':
        error = AuthErrors.weakPassword;
        break;
      case 'email-already-in-use':
        error = AuthErrors.emailAlreadyInUse;
        break;
      case 'user-not-found':
        error = AuthErrors.userNotFound;
        break;
      case 'wrong-password':
        error = AuthErrors.wrongPassword;
        break;
      case 'user-disabled':
        error = AuthErrors.userDisabled;
        break;
      case 'operation-not-allowed':
        error = AuthErrors.operationNotAllowed;
        break;
      case 'too-many-requests':
        error = AuthErrors.tooManyRequests;
        break;
      default:
        error = AuthErrors.unknown;
    }
    emit(state.copyWith(error: error));
    emit(AuthState(user: state.user));
  }
}
