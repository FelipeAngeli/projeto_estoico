import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/login/login_bloc.dart';
import 'package:projeto_estoico/app/bloc/login/login_events.dart';
import 'package:projeto_estoico/app/bloc/login/login_state.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';

class LoginController extends Disposable {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool isLoading = false;
  String error = '';

  // BLoC para o login
  final LoginBloc loginBloc;

  LoginController(this.loginBloc) {
    loginBloc.stream.listen((state) {
      if (state is LoginLoading) {
        isLoading = true;
      } else if (state is LoginSuccess) {
        isLoading = false;
        Modular.to.pushNamed('/home');
      } else if (state is LoginFailure) {
        isLoading = false;
        error = state.error;
      }
    });
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      loginBloc.add(LoginAttempt(username: username, password: password));
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    print('Tentativa de redefinição de senha com e-mail: ${emailController.text}');
    if (emailController.text.isEmpty) {
      print('Nenhum e-mail fornecido, exibindo SnackBar');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Por favor, insira seu email")));
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      print('E-mail de redefinição enviado com sucesso');
      showResetPasswordDialog(context);
    } catch (e) {
      print('Erro ao enviar e-mail de redefinição: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao enviar email: $e")));
    }
  }

  void showResetPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("E-mail enviado"),
          content: const Text("Um link para redefinição de senha foi enviado para o seu e-mail."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o dialog
              },
              child: Text("OK", style: TextStyle(color: CustomColor.verde)),
            ),
          ],
        );
      },
    );
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Por favor, insira seu e-mail';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Por favor, insira sua senha';
    return null;
  }

  @override
  void dispose() {
    loginBloc.close();
    emailController.dispose();
  }
}

// class LoginController extends Disposable {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController emailController = TextEditingController();

//   final formKey = GlobalKey<FormState>();
//   String username = '';
//   String password = '';
//   bool isLoading = false;
//   String error = '';

//   // BLoC para o login
//   final LoginBloc loginBloc;

//   LoginController(this.loginBloc) {
//     loginBloc.stream.listen((state) {
//       if (state is LoginLoading) {
//         isLoading = true;
//       } else if (state is LoginSuccess) {
//         isLoading = false;
//         // Navigate to home or another page
//         Modular.to.pushNamed('/home');
//       } else if (state is LoginFailure) {
//         isLoading = false;
//         error = state.error;
//       }
//     });
//   }

//   Future<void> login() async {
//     if (formKey.currentState!.validate()) {
//       formKey.currentState!.save();
//       loginBloc.add(LoginAttempt(username: username, password: password));
//     }
//   }

//   Future<void> resetPassword(BuildContext context) async {
//     if (emailController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Por favor, insira seu email")));
//       return;
//     }
//     try {
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Link de redefinição enviado! Verifique seu email.")));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao enviar email: $e")));
//     }
//   }

//   void showResetPasswordDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("E-mail enviado"),
//           content: Text("Um link para redefinição de senha foi enviado para o seu e-mail."),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Fecha o dialog
//               },
//               child: Text("OK", style: TextStyle(color: CustomColor.verde)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   String? validateUsername(String? value) {
//     if (value == null || value.isEmpty) return 'Please enter your email';
//     return null;
//   }

//   String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) return 'Please enter your password';
//     return null;
//   }

//   @override
//   void dispose() {
//     loginBloc.close();
//   }
// }

