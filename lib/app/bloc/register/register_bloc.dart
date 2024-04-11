import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_estoico/app/bloc/register/register_event.dart';
import 'package:projeto_estoico/app/bloc/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuth _auth;

  RegisterBloc(this._auth) : super(RegisterInitial()) {
    on<RegisterWithEmailPassword>(_onRegisterWithEmailPassword);
  }

  Future<void> _onRegisterWithEmailPassword(RegisterWithEmailPassword event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(RegisterSuccess(userId: userCredential.user!.uid));
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }
}
