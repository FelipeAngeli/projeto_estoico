// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:projeto_estoico/app/core/ui/base_state/base_state.dart';
// import 'package:projeto_estoico/app/modules/login/cubit/profile/auth_cubit.dart';
// import 'package:projeto_estoico/app/shared/widgets/button_custom.dart';
// import 'package:projeto_estoico/app/shared/widgets/textfield_custom.dart';
// import 'package:projeto_estoico/app/utils/color_custom.dart';
// import 'package:projeto_estoico/app/utils/font_custom.dart';
// import 'package:validatorless/validatorless.dart';

// class RegisterPasswordPage extends StatefulWidget {
//   const RegisterPasswordPage({super.key});

//   @override
//   State<RegisterPasswordPage> createState() => _RegisterPasswordPageState();
// }

// class _RegisterPasswordPageState extends BaseState<RegisterPasswordPage, AuthCubit> {
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool passwordFormFieldValid = false;
//   bool confirmPasswordFormFieldValid = false;
//   bool passwordVisible = false;

//   @override
//   void dispose() {
//     super.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: BlocConsumer<AuthCubit, AuthState>(
//             bloc: controller,
//             listener: (context, state) {
//               if (state is AuthErrorState) {
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                   content: Text(state.message),
//                 ));
//               }
//             },
//             builder: (context, state) {
//               return Scaffold(
//                 body: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Digite sua senha",
//                           style: FontCustom.montserratBold24.copyWith(color: ColorCustom.preto800),
//                         ),
//                         const SizedBox(height: 24),
//                         Text(
//                           "Agora precisamos criar uma senha",
//                           style: FontCustom.montserratRegular16.copyWith(color: ColorCustom.pretoBorda),
//                         ),
//                         const SizedBox(height: 64),
//                         TextFieldCustom(
//                           label: "Password",
//                           controller: _passwordController,
//                           obscureText: true,
//                           onChanged: (value) {
//                             if (value.isNotEmpty) {
//                               setState(() {
//                                 passwordFormFieldValid = true;
//                               });
//                             } else {
//                               setState(() {
//                                 passwordFormFieldValid = false;
//                               });
//                             }
//                           },
//                           icon: passwordVisible ? Icons.visibility : Icons.visibility_off,
//                           validator: Validatorless.multiple([
//                             Validatorless.required('A senha é obrigatória'),
//                             Validatorless.min(6, 'A senha deve conter no mínimo 6 caracteres')
//                           ]),
//                           onSaved: (value) {},
//                         ),
//                         const SizedBox(height: 32),
//                         Text(
//                           "Confirme sua senha",
//                           style: FontCustom.montserratRegular16.copyWith(color: ColorCustom.preto800),
//                         ),
//                         const SizedBox(height: 24),
//                         TextFieldCustom(
//                           label: "Password",
//                           controller: _confirmPasswordController,
//                           obscureText: true,
//                           onChanged: (value) {
//                             if (value.isNotEmpty) {
//                               setState(() {
//                                 passwordFormFieldValid = true;
//                               });
//                             } else {
//                               setState(() {
//                                 passwordFormFieldValid = false;
//                               });
//                             }
//                           },
//                           icon: passwordVisible ? Icons.visibility : Icons.visibility_off,
//                           validator: Validatorless.multiple([
//                             Validatorless.required('A senha é obrigatória'),
//                             Validatorless.min(6, 'A senha deve conter no mínimo 6 caracteres')
//                           ]),
//                           onSaved: (value) {},
//                         ),
//                         const Spacer(),
//                         ButtonCustom(
//                           type: CustomButtonType.elevated,
//                           width: double.infinity,
//                           height: 36,
//                           onPressed: state is AuthLoadingState
//                               ? null
//                               : () {
//                                   final validForm = _formKey.currentState?.validate() ?? false;
//                                   if (validForm) {
//                                     controller.signUp(password: _passwordController.text);
//                                   }
//                                   Modular.to.pushNamed('/registerFinish');
//                                 },
//                           style: passwordFormFieldValid
//                               ? ElevatedButton.styleFrom(
//                                   backgroundColor: ColorCustom.verde500,
//                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
//                               : ElevatedButton.styleFrom(
//                                   backgroundColor: ColorCustom.verde200,
//                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//                           child: state is AuthLoadingState
//                               ? const CircularProgressIndicator.adaptive()
//                               : Text(
//                                   'Continuar',
//                                   style: FontCustom.montserratBold16.copyWith(color: Colors.white),
//                                 ),
//                         ),
//                         const SizedBox(height: 24),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }));
//   }
// }
