import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/modules/login/bloc/register/register_event.dart';
import 'package:projeto_estoico/app/modules/login/bloc/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuth _auth;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  RegisterBloc(this._auth) : super(RegisterInitial()) {
    on<RegisterWithEmailPassword>(_onRegisterWithEmailPassword);
  }

  Future<void> _onRegisterWithEmailPassword(RegisterWithEmailPassword event, Emitter<RegisterState> emit) async {
    if (passwordController.text != confirmPasswordController.text) {
      emit(RegisterFailure(error: 'As senhas não coincidem.'));
      return;
    }

    emit(RegisterLoading());
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      emit(RegisterSuccess(userId: userCredential.user!.uid));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(error: 'A senha fornecida é muito fraca.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(error: 'Já existe uma conta para esse e-mail.'));
      } else {
        emit(RegisterFailure(error: e.message ?? 'Ocorreu um erro desconhecido.'));
      }
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
