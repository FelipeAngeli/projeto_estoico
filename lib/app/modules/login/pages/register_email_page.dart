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
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool emailFormFieldValid = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
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
                          style: FontCustom.montserratBold24.copyWith(color: ColorCustom.preto),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Digite o seu e-mail de preferência",
                          style: FontCustom.montserratRegular16.copyWith(color: ColorCustom.pretoBorda),
                        ),
                        const SizedBox(height: 64),
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
                                      email: _emailController.text,
                                    );
                                  }
                                  Modular.to.pushNamed('/login');
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
  



// class _RegistrationForm extends StatelessWidget {
//   _RegistrationForm({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final bloc = BlocProvider.of<RegisterBloc>(context);

//     return BlocListener<RegisterBloc, RegisterState>(
//       listener: (context, state) {
//         if (state is RegisterFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
//         } else if (state is RegisterSuccess) {
//           Modular.to.pushNamed('/search');
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//         child: Column(
//           children: [
//             TextFieldCustom(
//               controller: bloc.emailController,
//               label: "Email",
//             ),
//             const SizedBox(height: 16),
//             TextFieldCustom(
//               controller: bloc.passwordController,
//               label: "Senha",
//             ),
//             const SizedBox(height: 16),
//             TextFieldCustom(
//               controller: bloc.confirmPasswordController,
//               label: "Confirmar Senha",
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               // child: ButtonLoginCustom(
//               //   text: 'Registrar',
//               //   onPressed: () {
//               //     if (bloc.passwordController.text == bloc.confirmPasswordController.text) {
//               //       bloc.add(RegisterWithEmailPassword(
//               //         email: bloc.emailController.text,
//               //         password: bloc.passwordController.text,
//               //       ));
//               //     } else {
//               //       ScaffoldMessenger.of(context)
//               //           .showSnackBar(const SnackBar(content: Text('As senhas não coincidem.')));
//               //     }
//               //   },
//               // ),
//             ),
//             const Spacer(),
//             TextButton(
//               onPressed: () => Modular.to.pushNamed('/login'),
//               child: Text(
//                 'Já tem uma conta? Clique aqui',
//                 style: TextStyle(color: ColorCustom.verde),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
