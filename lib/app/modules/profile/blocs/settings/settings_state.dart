import 'package:flutter/material.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  SettingsLoaded({required String name, required String email, required String password})
      : nameController = TextEditingController(text: name),
        emailController = TextEditingController(text: email),
        passwordController = TextEditingController(text: password);
}

class SettingsError extends SettingsState {
  final String error;
  SettingsError(this.error);
}
