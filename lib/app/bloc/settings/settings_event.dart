import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadUserSettings extends SettingsEvent {}

class UpdateUserSettings extends SettingsEvent {
  final String name;
  final String email;
  final String password;

  const UpdateUserSettings({required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [name, email, password];
}
