import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/estoicimsmo/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicimsmo/estoicismo_event.dart';

class RegisterController {
  final formKey = GlobalKey<FormState>();
  final VoidCallback onSucessLogin;
  final VoidCallback onUpDate;
  String? username;
  String? password;
  String? confirmPassword;
  var _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    onUpDate();
  }

  RegisterController({required this.onSucessLogin, required this.onUpDate});

  var _error = "";
  String get error => _error;
  set error(String value) {
    _error = value;
    onUpDate();
  }

  final EstoicismoBloc estoicismoBloc = Modular.get<EstoicismoBloc>();

  void loadFrasesEstoicas() {
    estoicismoBloc.add(LoadEstoicismo());
  }

  void register() async {
    try {
      isLoading = true;
      final response =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: username!, password: password!);
      isLoading = false;
      if (response.user != null) {
        onSucessLogin();
      }
    } catch (e) {
      isLoading = false;
      error = ("Não foi possível fazer o login");
    }
  }

  bool validate() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String? validateUsername(String? username) => username != null && username.isNotEmpty ? null : "Campo obrigatório";
  String? validatePassword(String? password) =>
      password != null && password.length >= 6 ? null : "A senha deve ter no mínimo 6 caracteres";
  String? validateConfirmPassword(String? confirmPassword) =>
      confirmPassword != null && confirmPassword == password ? null : "As senhas não conferem";
}
