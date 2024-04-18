abstract class LoginEvent {}

class LoginAttempt extends LoginEvent {
  final String username;
  final String password;
  LoginAttempt({required this.username, required this.password});
}

class PasswordResetRequested extends LoginEvent {}
