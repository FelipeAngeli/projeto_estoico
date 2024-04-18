import 'package:projeto_estoico/app/models/user_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  ProfileLoaded(this.user);
}

class FrasesLoading extends ProfileState {}

class FrasesLoaded extends ProfileState {
  final List<String> frases;
  FrasesLoaded(this.frases);
}

class NoFrasesSaved extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
