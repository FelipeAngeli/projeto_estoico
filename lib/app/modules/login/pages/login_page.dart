import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/modules/login/bloc/login/login_bloc.dart';
import 'package:projeto_estoico/app/modules/login/bloc/login/login_events.dart';
import 'package:projeto_estoico/app/modules/login/bloc/login/login_state.dart';
import 'package:projeto_estoico/app/utils/components/btn_login_custom.dart';
import 'package:projeto_estoico/app/utils/components/login_txtfield_custom.dart';
import 'package:projeto_estoico/app/utils/components/password_txtfild_custom.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginBloc loginBloc;

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

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Por favor, insira seu e-mail';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Por favor, insira sua senha';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (_) => LoginBloc(),
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
            final bloc = BlocProvider.of<LoginBloc>(context);
            return _buildLoginForm(bloc, context, state);
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm(LoginBloc bloc, BuildContext context, LoginState state) {
    return Container(
      padding: const EdgeInsets.only(
        top: 88,
        left: 24,
        bottom: 24,
        right: 24,
      ),
      child: Form(
        key: bloc.formKey,
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
                controller: bloc.emailController, // Controlador para email
                validator: validateUsername,
                onSaved: (value) {
                  // A senha é salva diretamente pelo PasswordFieldWidget
                }),
            const SizedBox(height: 16),
            PasswordFieldWidger(
              label: "Password",
              controller: bloc.passwordController,
              validator: validatePassword,
              onSaved: (value) {
                // Sempre que o formulário for salvo, acionar o LoginAttempt
              },
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => bloc.add(PasswordResetRequested()),
                child: Text("Esqueceu a senha?", style: TextStyle(color: CustomColor.verde)),
              ),
            ),
            const SizedBox(height: 8),
            if (state is LoginLoading)
              const CircularProgressIndicator()
            else
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return CircularProgressIndicator(
                      color: CustomColor.verde,
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: BtnLoginCustom(
                      text: "Entrar",
                      onPressed: () => bloc.add(LoginAttempt(
                          username: bloc.emailController.text,
                          password: bloc.passwordController.text)), // Correção feita aqui
                    ),
                  );
                },
              ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 45,
            //   child: BtnLoginCustom(
            //     text: "Entrar",
            //     onPressed: () {
            //       if (bloc.formKey.currentState!.validate()) {
            //         bloc.formKey.currentState!.save(); // Garantir que os campos estão salvos
            //         bloc.add(LoginAttempt(
            //             username: bloc.emailController.text,
            //             password: bloc.passwordFieldController.text)); // Usando o valor diretamente do controlador
            //       }
            //     },
            //   ),
            // ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Não tem conta?"),
                TextButton(
                  onPressed: () => Modular.to.pushNamed('/register'),
                  child: Text("Crie a sua", style: TextStyle(color: CustomColor.verde)),
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
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK", style: TextStyle(color: CustomColor.verde)),
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
