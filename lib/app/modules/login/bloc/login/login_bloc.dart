import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/modules/login/bloc/login/login_events.dart';
import 'package:projeto_estoico/app/modules/login/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController(); // Controlador para senha
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginBloc() : super(LoginInitial()) {
    on<LoginAttempt>((event, emit) async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        emit(LoginLoading());
        try {
          await _auth.signInWithEmailAndPassword(email: event.username, password: event.password);
          emit(LoginSuccess());
        } catch (e) {
          emit(LoginFailure(e.toString()));
        }
      }
    });
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose(); // Lembre-se de descartar o controlador
    return super.close();
  }
}


// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   LoginBloc() : super(LoginInitial()) {
//     on<LoginAttempt>((event, emit) async {
//       emit(LoginLoading());
//       try {
//         await _auth.signInWithEmailAndPassword(email: event.username, password: event.password);
//         emit(LoginSuccess());
//       } catch (e) {
//         emit(LoginFailure(e.toString()));
//       }
//     });
//   }
// }
