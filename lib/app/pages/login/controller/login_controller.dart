import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/estoicimsmo/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicimsmo/estoicismo_event.dart';

class LoginController {
  final EstoicismoBloc estoicismoBloc = Modular.get<EstoicismoBloc>();

  String? username;
  String? password;

  var _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    onUpDate?.call(); // Chama o callback se não for nulo
  }

  var _error = "";
  String get error => _error;
  set error(String value) {
    _error = value;
    onUpDate?.call(); // Chama o callback se não for nulo
  }

  final formKey = GlobalKey<FormState>();

  VoidCallback? onSucessLogin;
  VoidCallback? onUpDate; // Removido o final para permitir reatribuição

  LoginController({this.onSucessLogin, this.onUpDate});

  void loadFrasesEstoicas() {
    estoicismoBloc.add(LoadEstoicismo());
  }

  Future<void> login() async {
    if (!validate()) return; // Garante a validação antes de prosseguir

    if (username == null || password == null) {
      error = "Username e/ou senha não podem ser vazios.";
      return;
    }

    try {
      isLoading = true;
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username!,
        password: password!,
      );
      if (response.user != null) {
        onSucessLogin?.call();
        Modular.to.pushNamed('/home');
      }
    } catch (e) {
      error = "Não foi possível fazer o login: $e"; // Melhor detalhamento do erro
    } finally {
      isLoading = false;
    }
  }

  bool validate() {
    final form = formKey.currentState;
    if (form?.validate() ?? false) {
      form!.save();
      return true;
    }
    return false;
  }

  String? validateUsername(String? username) => username != null && username.isNotEmpty ? null : "Campo obrigatório";

  String? validatePassword(String? password) =>
      password != null && password.length >= 6 ? null : "A senha precisa ter no mínimo 6 caracteres";

  void _notifyUpdate() {
    if (onUpDate != null) {
      onUpDate!();
    }
  }
}
