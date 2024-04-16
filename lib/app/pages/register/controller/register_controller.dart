import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/widgets.dart';

class RegisterController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  RegisterController() {
    // Considerar adicionar listeners para validação em tempo real
  }

  Future<void> register() async {
    if (passwordController.text != confirmPasswordController.text) {
      print('As senhas não coincidem.'); // Substituir por feedback adequado
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print('Usuário registrado com sucesso');
      Modular.to.pushNamed('/search'); // Sucesso, navega para a próxima tela
    } catch (e) {
      print('Erro ao registrar usuário: $e'); // Substituir por feedback adequado
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}

// class RegisterController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();

//   Future<void> register() async {
//     if (passwordController.text != confirmPasswordController.text) {
//       // Senhas não coincidem
//       print('As senhas não coincidem.'); // Aqui, considere uma melhor forma de feedback para o usuário
//       return;
//     }

//     try {
//       // Tenta criar um novo usuário com email e senha
//       await _auth.createUserWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );
//       // Se sucesso, navega para a tela principal
//       Modular.to.pushNamed('/search');
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//   }
// }

// class RegisterController {
//   final formKey = GlobalKey<FormState>();
//   final VoidCallback onSucessLogin;
//   final VoidCallback onUpDate;
//   String? eamilLogin;
//   String? password;
//   String? confirmPassword;
//   var _isLoading = false;
//   bool get isLoading => _isLoading;
//   set isLoading(bool value) {
//     _isLoading = value;
//     onUpDate();
//   }

//   RegisterController({required this.onSucessLogin, required this.onUpDate});

//   var _error = "";
//   String get error => _error;
//   set error(String value) {
//     _error = value;
//     onUpDate();
//   }

//   final SearchBloc searchBloc = Modular.get<SearchBloc>();

//   void loadFrasesEstoicas() {
//     // searchBloc.add((SearchLoading()));
//   }

//   void register() async {
//     try {
//       isLoading = true;
//       final response =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(email: eamilLogin!, password: password!);
//       isLoading = false;
//       if (response.user != null) {
//         onSucessLogin();
//       }
//     } catch (e) {
//       isLoading = false;
//       error = ("Não foi possível fazer o login");
//     }
//   }

//   bool validate() {
//     final form = formKey.currentState;
//     if (form!.validate()) {
//       form.save();
//       return true;
//     }
//     return false;
//   }

//   String? validateUsername(String? username) => username != null && username.isNotEmpty ? null : "Campo obrigatório";
//   String? validatePassword(String? password) =>
//       password != null && password.length >= 6 ? null : "A senha deve ter no mínimo 6 caracteres";
//   String? validateConfirmPassword(String? confirmPassword) =>
//       confirmPassword != null && confirmPassword == password ? null : "As senhas não conferem";
// }
