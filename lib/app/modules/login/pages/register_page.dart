import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/modules/login/bloc/register/register_bloc.dart';
import 'package:projeto_estoico/app/modules/login/bloc/register/register_event.dart';
import 'package:projeto_estoico/app/modules/login/bloc/register/register_state.dart';
import 'package:projeto_estoico/app/shared/widgets/btn_login_custom.dart';
import 'package:projeto_estoico/app/shared/widgets/login_txtfield_custom.dart';
import 'package:projeto_estoico/app/shared/widgets/password_txtfild_custom.dart';
import 'package:projeto_estoico/app/utils/color_custom.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar')),
      body: BlocProvider<RegisterBloc>(
        create: (context) => Modular.get<RegisterBloc>(),
        child: _RegistrationForm(),
      ),
    );
  }
}

class _RegistrationForm extends StatelessWidget {
  _RegistrationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RegisterBloc>(context);

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
              controller: bloc.emailController,
              label: "Email",
            ),
            const SizedBox(height: 16),
            PasswordFieldWidger(
              controller: bloc.passwordController,
              label: "Senha",
            ),
            const SizedBox(height: 16),
            PasswordFieldWidger(
              controller: bloc.confirmPasswordController,
              label: "Confirmar Senha",
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: BtnLoginCustom(
                text: 'Registrar',
                onPressed: () {
                  if (bloc.passwordController.text == bloc.confirmPasswordController.text) {
                    bloc.add(RegisterWithEmailPassword(
                      email: bloc.emailController.text,
                      password: bloc.passwordController.text,
                    ));
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
                'Já tem uma conta? Clique aqui',
                style: TextStyle(color: ColorCustom.verde),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
