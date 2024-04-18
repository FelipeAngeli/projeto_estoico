abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String userId;

  RegisterSuccess({required this.userId});
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure({required this.error});
}
