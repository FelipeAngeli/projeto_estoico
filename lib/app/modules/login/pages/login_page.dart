import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/core/ui/base_state/base_state.dart';
import 'package:projeto_estoico/app/modules/login/cubit/profile/auth_cubit.dart';
import 'package:projeto_estoico/app/shared/widgets/button_custom.dart';
import 'package:projeto_estoico/app/shared/widgets/textfield_custom.dart';
import 'package:projeto_estoico/app/utils/color_custom.dart';
import 'package:projeto_estoico/app/utils/font_custom.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, AuthCubit> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool emailFormFieldValid = false;
  bool passwordFormFieldValid = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: controller,
      listener: (context, state) {
        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
        if (state is AuthLoadedState) {
          Modular.to.pushNamed('/home');
          // Modular.to.pushReplacementNamed('/home');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 88),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/image/logo.png'),
                      width: 92,
                      height: 88,
                    ),
                    const SizedBox(height: 48),
                    Text(
                      "Faça seu login",
                      style: FontCustom.montserratSemiBold24.copyWith(color: ColorCustom.preto),
                    ),
                    const SizedBox(height: 48),
                    TextFieldCustom(
                      label: "E-mail",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            emailFormFieldValid = true;
                          });
                        } else {
                          setState(() {
                            emailFormFieldValid = false;
                          });
                        }
                      },
                      validator: Validatorless.multiple([
                        Validatorless.required("Email obrigatório"),
                        Validatorless.email("O email não é valido"),
                      ]),
                      onSaved: (value) {
                        print('Password saved: $value');
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldCustom(
                      label: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            passwordFormFieldValid = true;
                          });
                        } else {
                          setState(() {
                            passwordFormFieldValid = false;
                          });
                        }
                      },
                      validator: Validatorless.multiple([
                        Validatorless.required('A senha é obrigatória'),
                        Validatorless.min(6, 'A senha deve conter no mínimo 6 caracteres')
                      ]),
                      onSaved: (value) {
                        print('Password saved: $value');
                      },
                    ),
                    const SizedBox(height: 24),
                    ButtonCustom(
                      type: CustomButtonType.elevated,
                      width: double.infinity,
                      height: 36,
                      onPressed: state is AuthLoadingState
                          ? null
                          : () {
                              final validForm = _formKey.currentState?.validate() ?? false;
                              if (validForm) {
                                controller.signIn(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
                            },
                      style: emailFormFieldValid && passwordFormFieldValid
                          ? ElevatedButton.styleFrom(
                              backgroundColor: ColorCustom.verde500,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
                          : ElevatedButton.styleFrom(
                              backgroundColor: ColorCustom.verde200,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      child: state is AuthLoadingState
                          ? const CircularProgressIndicator.adaptive()
                          : Text(
                              'Entrar',
                              style: FontCustom.montserratBold16.copyWith(color: Colors.white),
                            ),
                    ),
                    const SizedBox(height: 28),
                    TextButton(
                      onPressed: () {
                        if (_emailController.text.isNotEmpty) {
                          Modular.get<AuthCubit>().resetPassword(_emailController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Se o e-mail estiver cadastrado, enviaremos um link para redefinição de senha."),
                              duration: Duration(seconds: 5),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Por favor, insira seu e-mail."),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Esqueceu a senha?",
                        style: FontCustom.montserratSemiBold16.copyWith(color: ColorCustom.preto),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.22),
                    TextButton(
                        child: Text(
                          "Não tem conta? Criar",
                          style: FontCustom.montserratSemiBold16.copyWith(color: ColorCustom.preto),
                        ),
                        onPressed: () {
                          Modular.to.pushNamed('/registerEmail');
                        })
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
