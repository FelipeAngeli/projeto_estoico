import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/register/register_bloc.dart';
import 'package:projeto_estoico/app/bloc/register/register_event.dart';
import 'package:projeto_estoico/app/bloc/register/register_state.dart';
import 'package:projeto_estoico/app/pages/register/controller/register_controller.dart';
import 'package:projeto_estoico/app/utils/components/login_txtfield_custom.dart';
import 'package:projeto_estoico/app/utils/components/password_txtfild_custom.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is RegisterSuccess) {
              Modular.to.pushNamed('/search');
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                LoginTextFieldCustom(
                  controller: _controller.emailController,
                  label: "Email",
                  // Adicione uma validação se necessário
                ),
                const SizedBox(height: 16),
                PasswordFieldWidger(
                  controller: _controller.passwordController,
                  label: "Senha",
                  // Adicione uma validação se necessário
                ),
                const SizedBox(height: 16),
                PasswordFieldWidger(
                  controller: _controller.confirmPasswordController,
                  label: "Confirmar Senha",
                  // Adicione uma validação para verificar se as senhas coincidem
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.passwordController.text == _controller.confirmPasswordController.text) {
                      // Disparando o evento de registro com os valores fornecidos
                      BlocProvider.of<RegisterBloc>(context).add(
                        RegisterWithEmailPassword(
                          email: _controller.emailController.text,
                          password: _controller.passwordController.text,
                        ),
                      );
                    } else {
                      // Lide aqui com o caso de as senhas não coincidirem
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('As senhas não coincidem.')),
                      );
                    }
                  },
                  child: const Text('Registrar'),
                ),
                TextButton(
                  onPressed: () => Modular.to.pushNamed('/login'),
                  child: const Text('Já tem uma conta? Entre aqui'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
