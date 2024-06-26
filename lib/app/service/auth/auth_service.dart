import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<User?> signIn({
    required String email,
    required String password,
  });
  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
  });
  Future<void> signOut();
  User? get currentUser;

  Future<void> sendPasswordResetEmail(String email);
}
