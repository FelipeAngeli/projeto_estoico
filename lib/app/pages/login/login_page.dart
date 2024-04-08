import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_event.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_state.dart';
import 'package:projeto_estoico/app/pages/login/controller/login_controller.dart';
import 'package:projeto_estoico/app/utils/components/login_txtfield_custom.dart';
import 'package:projeto_estoico/app/utils/components/password_txtfild_custom.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Modular.get<LoginController>();

  @override
  void initState() {
    super.initState();
    controller.estoicismoBloc.add(LoadEstoicismo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EstoicismoBloc, EstoicismoState>(
        bloc: controller.estoicismoBloc,
        builder: (context, state) {
          if (state is EstoicismoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EstoicismoLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Email"),
                  LoginTextFieldCustom(
                    label: "Email",
                    validator: controller.validateUsername,
                    onSaved: (value) => controller.username = value,
                  ),
                  SizedBox(height: 16),
                  PasswordFieldWidger(
                    label: "Password",
                    validator: controller.validatePassword,
                    onSaved: (value) => controller.password = value,
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
                        if (controller.validate()) {
                          controller.login();
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                        child: Text(
                          "Entrar",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text("Não tem conta?"),
                      // SizedBox(width: 8),
                      TextButton(
                        child: Text(
                          "Crie a sua",
                          style: TextStyle(color: CustomColor.verde),
                        ),
                        style: TextButton.styleFrom(),
                        onPressed: () {
                          Modular.to.pushNamed('/register');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is EstoicismoError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
