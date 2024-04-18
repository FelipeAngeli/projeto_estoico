import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/modules/login/bloc/login/login_events.dart';
import 'package:projeto_estoico/app/modules/login/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

  LoginBloc() : super(LoginInitial()) {
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);

    on<LoginEmailSaved>((event, emit) {
      emailController.text = event.email;
      print('Email saved: ${event.email}');
    });

    on<LoginPasswordSaved>((event, emit) {
      passwordController.text = event.password;
      print('Password saved: ${event.password}');
    });

    on<LoginAttempt>(loginAttemptHandler);
    on<PasswordResetRequested>(_handlePasswordResetRequested);
  }

  void _updateButtonState() {
    bool formIsValid = formKey.currentState?.validate() ?? false;
    print('Form is valid: $formIsValid');
    isButtonEnabled.value = formIsValid;
  }

  Future<void> loginAttemptHandler(LoginAttempt event, Emitter<LoginState> emit) async {
    print('Login attempt received: $event');
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
  }

  Future<void> _handlePasswordResetRequested(PasswordResetRequested event, Emitter<LoginState> emit) async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      emit(PasswordResetEmailSent());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    emailController.removeListener(_updateButtonState);
    passwordController.removeListener(_updateButtonState);
    emailController.dispose();
    passwordController.dispose();
    isButtonEnabled.dispose();
    return super.close();
  }
}

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   LoginBloc() : super(LoginInitial()) {
//     on<LoginEmailSaved>((event, emit) => emailController.text = event.email);
//     on<LoginPasswordSaved>((event, emit) => passwordController.text = event.password);
//     on<LoginAttempt>(loginAttemptHandler);
//     on<PasswordResetRequested>(_handlePasswordResetRequested);
//   }

//   Future<void> loginAttemptHandler(LoginAttempt event, Emitter<LoginState> emit) async {
//     if (formKey.currentState!.validate()) {
//       formKey.currentState!.save();
//       emit(LoginLoading());
//       try {
//         await _auth.signInWithEmailAndPassword(email: event.username, password: event.password);
//         emit(LoginSuccess());
//       } catch (e) {
//         emit(LoginFailure(e.toString()));
//       }
//     }
//   }

//   Future<void> _handlePasswordResetRequested(PasswordResetRequested event, Emitter<LoginState> emit) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: emailController.text);
//       emit(PasswordResetEmailSent());
//     } catch (e) {
//       emit(LoginFailure(e.toString()));
//     }
//   }

//   @override
//   Future<void> close() {
//     emailController.dispose();
//     passwordController.dispose();
//     return super.close();
//   }
// }

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
