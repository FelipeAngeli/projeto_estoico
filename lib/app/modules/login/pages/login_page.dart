import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/modules/login/bloc/login/login_bloc.dart';
import 'package:projeto_estoico/app/modules/login/bloc/login/login_events.dart';
import 'package:projeto_estoico/app/modules/login/bloc/login/login_state.dart';
import 'package:projeto_estoico/app/shared/widgets/btn_login_custom.dart';
import 'package:projeto_estoico/app/shared/widgets/login_txtfield_custom.dart';
import 'package:projeto_estoico/app/shared/widgets/password_txtfild_custom.dart';
import 'package:projeto_estoico/app/utils/color_custom.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginBloc loginBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (_) => loginBloc,
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is LoginSuccess) {
              Modular.to.pushNamed('/search');
            } else if (state is PasswordResetEmailSent) {
              showResetPasswordDialog(context);
            }
          },
          builder: (context, state) {
            return _buildLoginForm(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, LoginState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 88),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/image/logo.png'),
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 40),
            LoginTextFieldCustom(
              label: "Email",
              controller: loginBloc.emailController,
              validator: Validatorless.multiple([
                Validatorless.required("Email obrigatório"),
                Validatorless.email("O email não é valido"),
              ]),
              onSaved: (value) {
                if (value != null) {
                  loginBloc.add(LoginEmailSaved(value));
                }
                print('Email saved: $value');
              },
            ),
            const SizedBox(height: 16),
            PasswordFieldWidger(
              label: "Password",
              controller: loginBloc.passwordController,
              validator: Validatorless.multiple([
                Validatorless.required('A senha é obrigatória'),
                Validatorless.min(6, 'A senha deve conter no mínimo 6 caracteres')
              ]),
              onSaved: (value) {
                if (value != null) {
                  loginBloc.add(LoginPasswordSaved(value));
                }
                print('Password saved: $value');
              },
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  print('Password reset requested');
                  loginBloc.add(PasswordResetRequested());
                },
                child: Text("Esqueceu a senha?", style: TextStyle(color: ColorCustom.verde)),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: BtnLoginCustom(
                  text: "Entrar",
                  backgroundColor: ColorCustom.verde,
                  onPressed: () {
                    if (loginBloc.formKey.currentState!.validate()) {
                      print('Form is valid');
                      loginBloc.formKey.currentState!.save();
                      loginBloc.add(LoginAttempt(
                        username: loginBloc.emailController.text,
                        password: loginBloc.passwordController.text,
                      ));
                    }
                  }),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Não tem conta?"),
                TextButton(
                  onPressed: () {
                    print('Create account button pressed');
                    Modular.to.pushNamed('/register');
                  },
                  child: Text("Crie a sua", style: TextStyle(color: ColorCustom.verde)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
                print('Reset password dialog closed');
                Navigator.of(context).pop();
              },
              child: Text("OK", style: TextStyle(color: ColorCustom.verde)),
            ),
          ],
        );
      },
    );
  }
}

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   late final LoginBloc loginBloc;
//   late final LoginController controller;

//   @override
//   void initState() {
//     super.initState();
//     loginBloc = LoginBloc();
//     controller = LoginController(loginBloc);
//   }

//   @override
//   void dispose() {
//     loginBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider<LoginBloc>(
//         create: (_) => loginBloc,
//         child: BlocListener<LoginBloc, LoginState>(
//           listener: (context, state) {
//             if (state is LoginFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
//             } else if (state is LoginSuccess) {
//               Modular.to.pushNamed('/search');
//             }
//           },
//           child: _buildLoginForm(),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoginForm() {
//     return Container(
//       padding: const EdgeInsets.only(
//         top: 88,
//         left: 24,
//         bottom: 24,
//         right: 24,
//       ),
//       child: Form(
//         key: controller.formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Image(
//               image: AssetImage('assets/image/logo.png'),
//               width: 150,
//               height: 150,
//             ),
//             const SizedBox(height: 40),
//             LoginTextFieldCustom(
//                 label: "Email",
//                 controller: controller.emailController, // Use the controller from LoginController
//                 validator: controller.validateUsername,
//                 onSaved: (value) {
//                   controller.username = value ?? '';
//                 }),
//             const SizedBox(height: 16),
//             PasswordFieldWidger(
//               label: "Password",
//               validator: controller.validatePassword,
//               onSaved: (value) => controller.password = value!,
//             ),
//             const SizedBox(height: 8),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {
//                   controller.resetPassword(context);
//                 },
//                 child: Text(
//                   "Esqueceu a senha?",
//                   style: TextStyle(color: CustomColor.verde),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             BlocBuilder<LoginBloc, LoginState>(
//               builder: (context, state) {
//                 if (state is LoginLoading) {
//                   return const CircularProgressIndicator();
//                 }
//                 return SizedBox(
//                   width: double.infinity,
//                   height: 45,
//                   child: BtnLoginCustom(
//                     text: "Entrar",
//                     onPressed: controller.login,
//                   ),
//                 );
//               },
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Não tem conta?"),
//                 TextButton(
//                   onPressed: () {
//                     Modular.to.pushNamed('/register');
//                   },
//                   child: Text(
//                     "Crie a sua",
//                     style: TextStyle(color: CustomColor.verde),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
