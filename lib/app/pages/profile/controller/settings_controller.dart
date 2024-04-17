import 'package:flutter/material.dart';

class SettingsController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void saveSettings() {
    // Aqui você pode adicionar lógica para salvar as configurações
    print("Salvando configurações");
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
