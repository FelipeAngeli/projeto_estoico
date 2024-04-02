import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_event.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_state.dart';
import 'package:projeto_estoico/app/data/repository/estoicismo_repoitory.dart';
import 'package:projeto_estoico/app/utils/app_error.dart';

class EstoicismoBloc extends Bloc<EstoicismoEvent, EstoicismoState> {
  final EstoicismoRepository repository;

  EstoicismoBloc({required this.repository}) : super(EstoicismoInitial()) {
    on<LoadEstoicismo>((event, emit) async {
      emit(EstoicismoLoading());
      try {
        final frases = await repository.getFrasesEstoicas();
        emit(EstoicismoLoaded(frases));
      } catch (error) {
        if (error is AppError) {
          emit(EstoicismoError(error.message));
        } else {
          emit(EstoicismoError('Erro desconhecido'));
        }
      }
    });
  }
}
