import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/bloc/login/login_events.dart';
import 'package:projeto_estoico/app/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(LoginInitial()) {
    on<LoginAttempt>((event, emit) async {
      emit(LoginLoading());
      try {
        await _auth.signInWithEmailAndPassword(email: event.username, password: event.password);
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
