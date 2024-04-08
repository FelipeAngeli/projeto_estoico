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
  final RegisterController controller = Modular.get<RegisterController>();

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
                  const Text("Email"),
                  const LoginTextFieldCustom(
                    label: "Email",
                  ),
                  const SizedBox(height: 16),
                  const PasswordFieldWidger(
                    label: "Password",
                  ),
                  const PasswordFieldWidger(
                    label: "Confirm Password",
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: const Text("Cadastrar"),
                    onPressed: () {
                      Modular.to.pushNamed('/home');
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(),
                    onPressed: () {
                      Modular.to.pushNamed('/login');
                    },
                    child: Text(
                      "Voltar",
                      style: TextStyle(color: CustomColor.verde),
                    ),
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
