// Eventos
abstract class LoginEvent {}

class LoginEmailSaved extends LoginEvent {
  final String email;
  LoginEmailSaved(this.email);
}

class LoginPasswordSaved extends LoginEvent {
  final String password;
  LoginPasswordSaved(this.password);
}

class LoginAttempt extends LoginEvent {
  final String username;
  final String password;
  LoginAttempt({required this.username, required this.password});
}

class PasswordResetRequested extends LoginEvent {}
