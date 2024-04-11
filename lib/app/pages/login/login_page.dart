import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/login/login_bloc.dart';
import 'package:projeto_estoico/app/bloc/login/login_state.dart';

import 'package:projeto_estoico/app/pages/login/controller/login_controller.dart';
import 'package:projeto_estoico/app/utils/components/login_txtfield_custom.dart';
import 'package:projeto_estoico/app/utils/components/password_txtfild_custom.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginBloc loginBloc;
  late final LoginController controller;

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc(); // Instancia o LoginBloc
    controller = LoginController(loginBloc); // Passa o LoginBloc para o Controller
  }

  @override
  void dispose() {
    loginBloc.close(); // Fecha o LoginBloc quando a página é desmontada
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (_) => loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is LoginSuccess) {
              // Navegue para a página inicial ou qualquer outra página necessária
              Modular.to.pushNamed('/search');
            }
          },
          child: _buildLoginForm(),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Email"),
            LoginTextFieldCustom(
              label: "Email",
              validator: controller.validateUsername,
              onSaved: (value) => controller.username = value!,
            ),
            const SizedBox(height: 16),
            PasswordFieldWidger(
              label: "Password",
              validator: controller.validatePassword,
              onSaved: (value) => controller.password = value!,
            ),
            const SizedBox(height: 20),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: controller.login,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Não tem conta?"),
                TextButton(
                  onPressed: () {
                    Modular.to.pushNamed('/register');
                  },
                  child: Text(
                    "Crie a sua",
                    style: TextStyle(color: CustomColor.verde),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
