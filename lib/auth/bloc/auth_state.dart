import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hue_dada/auth/model/auth_errors.dart';

class AuthState extends Equatable {
  const AuthState({
    this.user,
    this.error,
  });

  final User? user;
  final AuthErrors? error;

  AuthState copyWith({
    User? user,
    AuthErrors? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        user,
        error,
      ];
}

enum AuthStateStatus {
  initial,
  loggedIn,
  loggedOut,
}
