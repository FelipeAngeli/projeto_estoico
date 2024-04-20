import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/core/exceptions/auth_exception.dart';
import 'package:projeto_estoico/app/service/auth/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthService authService})
      : _authService = authService,
        super(AuthInitialState());

  final AuthService _authService;

  Future<void> signUp({
    String? email,
    String? password,
    String? name,
  }) async {
    emit(AuthLoadingState());
    try {
      final user = await _authService.signUp(
        email: email ?? '',
        password: password ?? '',
        name: name ?? '',
      );
      emit(AuthLoadedState(user: user));
    } on AuthException catch (e, s) {
      log('Erro ao criar usuário', error: e, stackTrace: s);
      emit(AuthErrorState(message: e.message));
    } catch (e, s) {
      log('Erro ao criar usuário', error: e, stackTrace: s);
      emit(AuthErrorState(message: 'Erro ao criar usuário'));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    try {
      final user = await _authService.signIn(
        email: email,
        password: password,
      );
      emit(AuthLoadedState(user: user));
    } on AuthException catch (e, s) {
      log('Erro ao fazer login', error: e, stackTrace: s);
      emit(AuthErrorState(message: e.message));
    } catch (e, s) {
      log('Erro ao fazer login', error: e, stackTrace: s);
      emit(AuthErrorState(message: 'Erro ao fazer login'));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoadingState());
    try {
      await _authService.signOut();
      emit(AuthInitialState());
    } catch (e, s) {
      log('Erro ao fazer logout', error: e, stackTrace: s);
      emit(AuthErrorState(message: 'Erro ao fazer logout'));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoadingState());
    try {
      await _authService.sendPasswordResetEmail(email);
      emit(AuthMessageState(message: 'E-mail de redefinição de senha enviado com sucesso.'));
    } catch (e, s) {
      log('Erro ao enviar e-mail de redefinição de senha', error: e, stackTrace: s);
      emit(AuthErrorState(message: 'Erro ao enviar e-mail de redefinição de senha.'));
    }
  }
}
