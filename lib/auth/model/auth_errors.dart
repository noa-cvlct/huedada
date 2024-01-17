enum AuthErrors {
  // Fields errors
  emptyEmail,
  emptyPassword,
  emptyConfirmPassword,
  passwordsDontMatch,

  // Firebase Auth errors
  invalidEmail,
  weakPassword,
  emailAlreadyInUse,
  userNotFound,
  wrongPassword,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  unknown;

  String get message {
    switch (this) {
      case AuthErrors.emptyEmail:
        return 'Email is empty';
      case AuthErrors.emptyPassword:
        return 'Password is empty';
      case AuthErrors.emptyConfirmPassword:
        return 'Confirm password is empty';
      case AuthErrors.passwordsDontMatch:
        return 'Passwords don\'t match';
      case AuthErrors.invalidEmail:
        return 'Invalid email';
      case AuthErrors.weakPassword:
        return 'Weak password';
      case AuthErrors.emailAlreadyInUse:
        return 'Email already in use';
      case AuthErrors.userNotFound:
        return 'User not found';
      case AuthErrors.wrongPassword:
        return 'Wrong password';
      case AuthErrors.userDisabled:
        return 'User disabled';
      case AuthErrors.operationNotAllowed:
        return 'Operation not allowed';
      case AuthErrors.tooManyRequests:
        return 'Too many requests';
      case AuthErrors.unknown:
        return 'Unknown error';
      default:
        return 'Undefined error';
    }
  }
}
