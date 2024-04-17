import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final String name;
  final String email;
  final String password;

  const SettingsLoaded({required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}

class SettingsError extends SettingsState {
  final String error;

  const SettingsError(this.error);

  @override
  List<Object?> get props => [error];
}
