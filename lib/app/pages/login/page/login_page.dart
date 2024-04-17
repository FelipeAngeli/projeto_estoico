import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/login/login_bloc.dart';
import 'package:projeto_estoico/app/bloc/login/login_state.dart';

import 'package:projeto_estoico/app/pages/login/controller/login_controller.dart';
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
  late final LoginController controller;

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
    controller = LoginController(loginBloc);
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
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is LoginSuccess) {
              Modular.to.pushNamed('/search');
            }
          },
          child: _buildLoginForm(),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.only(
        top: 88,
        left: 24,
        bottom: 24,
        right: 24,
      ),
      child: Form(
        key: controller.formKey,
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
                controller: controller.emailController, // Use the controller from LoginController
                validator: controller.validateUsername,
                onSaved: (value) {
                  controller.username = value ?? '';
                }),
            const SizedBox(height: 16),
            PasswordFieldWidger(
              label: "Password",
              validator: controller.validatePassword,
              onSaved: (value) => controller.password = value!,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  controller.resetPassword(context);
                },
                child: Text(
                  "Esqueceu a senha?",
                  style: TextStyle(color: CustomColor.verde),
                ),
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const CircularProgressIndicator();
                }
                return SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: BtnLoginCustom(
                    text: "Entrar",
                    onPressed: controller.login,
                  ),
                );
              },
            ),
            const Spacer(),
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
