import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_estoico/app/bloc/register/register_event.dart';
import 'package:projeto_estoico/app/bloc/register/register_state.dart';
import 'package:projeto_estoico/app/data/repository/estoicismo_repoitory.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuth _auth;
  final EstoicismoRepository _estoicismoRepository;

  // Inicializa o bloc com as instâncias FirebaseAuth e EstoicismoRepository.
  RegisterBloc(this._auth, this._estoicismoRepository) : super(RegisterInitial()) {
    on<RegisterWithEmailPassword>(_onRegisterWithEmailPassword);
  }

  // Método para lidar com o evento de registro usando e-mail e senha.
  Future<void> _onRegisterWithEmailPassword(RegisterWithEmailPassword event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading()); // Emite o estado de carregamento
    try {
      // Tenta criar um usuário com e-mail e senha
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(RegisterSuccess(userId: userCredential.user!.uid)); // Emite sucesso se o registro for bem-sucedido
    } on FirebaseAuthException catch (e) {
      // Trata exceções específicas do Firebase
      if (e.code == 'weak-password') {
        emit(RegisterFailure(error: 'A senha fornecida é muito fraca.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(error: 'Já existe uma conta para esse e-mail.'));
      } else {
        emit(RegisterFailure(error: e.message ?? 'Ocorreu um erro desconhecido.'));
      }
    } catch (e) {
      emit(RegisterFailure(error: e.toString())); // Trata quaisquer outras exceções
    }
  }
}
