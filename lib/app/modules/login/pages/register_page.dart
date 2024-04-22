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

class RegisterEmailPage extends StatefulWidget {
  const RegisterEmailPage({super.key});

  @override
  State<RegisterEmailPage> createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends BaseState<RegisterEmailPage, AuthCubit> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool nameFormFieldValid = false;
  bool emailFormFieldValid = false;
  bool passwordFormFieldValid = false;
  bool confirmPasswordFormFieldValid = false;
  bool passwordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<AuthCubit, AuthState>(
            bloc: controller,
            listener: (context, state) {
              if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Digite seu e-mail",
                          style: FontCustom.montserratBold24.copyWith(color: ColorCustom.preto800),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Digite o seu e-mail de preferência",
                          style: FontCustom.montserratRegular16.copyWith(color: ColorCustom.pretoBorda),
                        ),
                        const SizedBox(height: 64),
                        TextFieldCustom(
                          label: "Nome",
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                nameFormFieldValid = true;
                              });
                            } else {
                              setState(() {
                                nameFormFieldValid = false;
                              });
                            }
                          },
                          validator: Validatorless.multiple([
                            Validatorless.required("Nome obrigatório"),
                            // Validatorless.min(3,("O email não é valido")),
                          ]),
                          onSaved: (value) {},
                        ),
                        const SizedBox(height: 16),
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
                          onSaved: (value) {},
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          label: "Password",
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          icon: passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                          onSaved: (value) {},
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          label: "Confrirm Password",
                          controller: _confirmPasswordController,
                          keyboardType: TextInputType.text,
                          icon: passwordVisible ? Icons.visibility : Icons.visibility_off,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                confirmPasswordFormFieldValid = true;
                              });
                            } else {
                              setState(() {
                                confirmPasswordFormFieldValid = false;
                              });
                            }
                          },
                          validator: Validatorless.multiple([
                            Validatorless.required('A senha é obrigatória'),
                            Validatorless.min(6, 'A senha deve conter no mínimo 6 caracteres')
                          ]),
                          onSaved: (value) {},
                        ),
                        const Spacer(),
                        ButtonCustom(
                          type: CustomButtonType.elevated,
                          width: double.infinity,
                          height: 36,
                          onPressed: state is AuthLoadingState
                              ? null
                              : () {
                                  final validForm = _formKey.currentState?.validate() ?? false;
                                  if (validForm) {
                                    controller.signUp(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text);
                                  }
                                  Modular.to.pushNamed('/registerFinish');
                                },
                          style: emailFormFieldValid
                              ? ElevatedButton.styleFrom(
                                  backgroundColor: ColorCustom.verde500,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
                              : ElevatedButton.styleFrom(
                                  backgroundColor: ColorCustom.verde200,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          child: state is AuthLoadingState
                              ? const CircularProgressIndicator.adaptive()
                              : Text(
                                  'Continuar',
                                  style: FontCustom.montserratBold16.copyWith(color: Colors.white),
                                ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
