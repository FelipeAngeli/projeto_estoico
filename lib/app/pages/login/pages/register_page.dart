import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/register/register_bloc.dart';
import 'package:projeto_estoico/app/bloc/register/register_event.dart';
import 'package:projeto_estoico/app/bloc/register/register_state.dart';
import 'package:projeto_estoico/app/pages/login/controller/register_controller.dart';
import 'package:projeto_estoico/app/utils/components/btn_login_custom.dart';
import 'package:projeto_estoico/app/utils/components/login_txtfield_custom.dart';
import 'package:projeto_estoico/app/utils/components/password_txtfild_custom.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final RegisterController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RegisterController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar')),
      body: BlocProvider<RegisterBloc>(
        create: (context) => Modular.get<RegisterBloc>(),
        child: _RegistrationForm(controller: _controller),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _RegistrationForm extends StatelessWidget {
  final RegisterController controller;

  const _RegistrationForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state is RegisterSuccess) {
          Modular.to.pushNamed('/search');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            LoginTextFieldCustom(
              controller: controller.emailController,
              label: "Email",
            ),
            const SizedBox(height: 16),
            PasswordFieldWidger(
              controller: controller.passwordController,
              label: "Senha",
            ),
            const SizedBox(height: 16),
            PasswordFieldWidger(
              controller: controller.confirmPasswordController,
              label: "Confirmar Senha",
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: BtnLoginCustom(
                text: 'Registrar',
                onPressed: () {
                  if (controller.passwordController.text == controller.confirmPasswordController.text) {
                    BlocProvider.of<RegisterBloc>(context).add(
                      RegisterWithEmailPassword(
                        email: controller.emailController.text,
                        password: controller.passwordController.text,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('As senhas não coincidem.')));
                  }
                },
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => Modular.to.pushNamed('/login'),
              child: Text(
                'Já tem uma conta? Click aqui',
                style: TextStyle(color: CustomColor.verde),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   late final RegisterController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = RegisterController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Registrar')),
//       body: BlocProvider<RegisterBloc>(
//         create: (context) => Modular.get<RegisterBloc>(),
//         child: BlocListener<RegisterBloc, RegisterState>(
//           listener: (context, state) {
//             if (state is RegisterFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
//             } else if (state is RegisterSuccess) {
//               Modular.to.pushNamed('/search');
//             }
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 24,
//               vertical: 24,
//             ),
//             child: Column(
//               children: [
//                 LoginTextFieldCustom(
//                   controller: _controller.emailController,
//                   label: "Email",
//                   // Adicione uma validação se necessário
//                 ),
//                 const SizedBox(height: 16),
//                 PasswordFieldWidger(
//                   controller: _controller.passwordController,
//                   label: "Senha",
//                   // Adicione uma validação se necessário
//                 ),
//                 const SizedBox(height: 16),
//                 PasswordFieldWidger(
//                   controller: _controller.confirmPasswordController,
//                   label: "Confirmar Senha",
//                   // Adicione uma validação para verificar se as senhas coincidem
//                 ),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   child: BtnLoginCustom(
//                     text: 'Registrar',
//                     onPressed: () {
//                       if (_controller.passwordController.text == _controller.confirmPasswordController.text) {
//                         BlocProvider.of<RegisterBloc>(context).add(
//                           RegisterWithEmailPassword(
//                             email: _controller.emailController.text,
//                             password: _controller.passwordController.text,
//                           ),
//                         );
//                         print('Registrado com sucesso!');
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('As senhas não coincidem.')),
//                         );
//                         print('faha ao registar!');
//                       }
//                     },
//                   ),
//                 ),
//                 const Spacer(),
//                 TextButton(
//                   onPressed: () => Modular.to.pushNamed('/login'),
//                   child: Text(
//                     'Já tem uma conta? Click aqui',
//                     style: TextStyle(color: CustomColor.verde),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
