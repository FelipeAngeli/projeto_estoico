abstract class RegisterEvent {}

class RegisterWithEmailPassword extends RegisterEvent {
  final String email;
  final String password;

  RegisterWithEmailPassword({required this.email, required this.password});
}
