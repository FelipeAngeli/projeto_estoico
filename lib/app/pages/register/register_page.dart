import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_event.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_state.dart';
import 'package:projeto_estoico/app/pages/register/controller/register_controller.dart';
import 'package:projeto_estoico/app/utils/components/login_txtfield_custom.dart';
import 'package:projeto_estoico/app/utils/components/password_txtfild_custom.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Modular.get<RegisterController>();

    // late final controller = RegisterController(
    //   onSucessLogin: () => Modular.to.pushNamed('/home'),
    //   onUpDate: () => setState(() {}),
    // );

    return BlocProvider<EstoicismoBloc>(
      create: (context) => controller.estoicismoBloc..add(LoadEstoicismo()),
      child: Scaffold(
        body: BlocConsumer<EstoicismoBloc, EstoicismoState>(
          listener: (context, state) {
            if (state is EstoicismoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is EstoicismoLoaded) {
              controller.onSucessLogin.call();
            }
          },
          builder: (context, state) {
            if (state is EstoicismoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EstoicismoLoaded || state is EstoicismoInitial) {
              return _buildRegisterForm(context, controller);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context, RegisterController controller) {
    // Utilizando GlobalKey para o formulário
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginTextFieldCustom(
              label: "Email",
              validator: controller.validateUsername,
              onSaved: (value) => controller.username = value,
            ),
            const SizedBox(height: 16),
            PasswordFieldWidger(
              label: "Password",
              validator: controller.validatePassword,
              onSaved: (value) => controller.password = value,
            ),
            const SizedBox(height: 16),
            PasswordFieldWidger(
              label: "Confirm Password",
              validator:
                  controller.validatePassword, // Aqui você pode querer uma validação específica para confirmar senha
              onSaved: (value) => {
                controller.confirmPassword = value
              }, // Supondo que você lide com a confirmação de senha de forma adequada
            ),
            const SizedBox(height: 20),
            if (controller.isLoading)
              const CircularProgressIndicator()
            else if (controller.error.isNotEmpty)
              Text(
                controller.error,
                style: const TextStyle(color: Colors.red),
              )
            else
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    controller.register();
                    Modular.to.pushNamed('/home');
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            TextButton(
              style: TextButton.styleFrom(),
              onPressed: () => Modular.to.pushNamed('/login'),
              child: Text(
                "Voltar",
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
//   late final controller = RegisterController(onSucessLogin: () {
//     Modular.to.pushNamed('/home');
//   }, onUpDate: () {
//     setState(() {});
//   });

//   @override
//   void initState() {
//     super.initState();
//     controller.estoicismoBloc.add(LoadEstoicismo());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<EstoicismoBloc, EstoicismoState>(
//         bloc: controller.estoicismoBloc,
//         builder: (context, state) {
//           if (state is EstoicismoLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is EstoicismoLoaded) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Email"),
//                   const LoginTextFieldCustom(
//                     label: "Email",
//                     validator: controller.validateUsername,
//                     onSaved: (value) => controller.username = value,
//                   ),
//                   const SizedBox(height: 16),
//                   const PasswordFieldWidger(
//                     label: "Password",
//                     validator: controller.validatePassword,
//                     onSaved: (value) => controller.password = value,
//                   ),
//                   const PasswordFieldWidger(
//                     label: "Confirm Password",
//                     validator: controller.validatePassword,
//                     onSaved: (value) => controller.password = value,
//                   ),
//                   const SizedBox(height: 16),
//                   if (controller.isLoading)
//                     const CircularProgressIndicator()
//                   else if (controller.error.isNotEmpty)
//                     Text(
//                       controller.error,
//                       style: const TextStyle(color: Colors.red),
//                     )
//                   else
//                     ElevatedButton(
//                       onPressed: () {
//                         if (controller.formKey.currentState!.validate()) {
//                           controller.formKey.currentState!.save();
//                           controller.register();
//                         }
//                       },
//                       child: const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
//                         child: Text(
//                           "Cadastrar",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                     ),
//                   TextButton(
//                     style: TextButton.styleFrom(),
//                     onPressed: () {
//                       Modular.to.pushNamed('/login');
//                     },
//                     child: Text(
//                       "Voltar",
//                       style: TextStyle(color: CustomColor.verde),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is EstoicismoError) {
//             return Center(child: Text(state.message));
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }
// }
