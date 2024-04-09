import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/estoicimsmo/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicimsmo/estoicismo_state.dart';
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
  late final LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = Modular.get<LoginController>();
    // Define o callback de atualização para chamar setState quando o estado interno do controller mudar
    controller.onUpDate = () => setState(() {});
    // Inicializa o carregamento de dados, se necessário
    controller.loadFrasesEstoicas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => controller.estoicismoBloc,
        child: BlocListener<EstoicismoBloc, EstoicismoState>(
          listener: (context, state) {
            if (state is EstoicismoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: _buildLoginForm(context),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    // O método foi extraído para melhor organização
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
              onSaved: (value) => controller.username = value,
            ),
            const SizedBox(height: 16),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Não tem conta?"),
                TextButton(
                  onPressed: () {
                    Modular.to.pushNamed('/register');
                  },
                  child: Container(
                    color: Colors.red,
                    child: Text(
                      "Crie a sua",
                      style: TextStyle(color: CustomColor.verde),
                    ),
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
