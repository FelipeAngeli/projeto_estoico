import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_estoico/app/core/exceptions/auth_exception.dart';
import 'package:projeto_estoico/app/service/auth/auth_service.dart';

class AuthServiceImpl implements AuthService {
  final _auth = FirebaseAuth.instance;

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e, s) {
      log("Erro ao fazer login", error: e, stackTrace: s);
      handleFirebaseAuthError(e);
    }
    return null;
  }

  @override
  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        final latestUser = currentUser;
        return latestUser;
      }
    } on FirebaseAuthException catch (e, s) {
      log("Erro ao criar conta", error: e, stackTrace: s);
      handleFirebaseAuthError(e);
    }
    return null;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      print("Enviando e-mail de redefinição de senha para: $email");
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Falha ao enviar e-mail para: $email");
      throw Exception('Falha ao enviar e-mail de redefinição de senha');
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  User? get currentUser => _auth.currentUser;
}
