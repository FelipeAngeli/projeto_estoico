import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/bloc/frasedodia/frasedodia_events.dart';
import 'package:projeto_estoico/app/bloc/frasedodia/frasedodia_states.dart';
import 'package:projeto_estoico/app/data/repository/estoicismo_repoitory.dart';

class FraseDoDiaBloc extends Bloc<FraseDoDiaEvent, FraseDoDiaState> {
  final EstoicismoRepository repository;

  FraseDoDiaBloc(this.repository) : super(FraseDoDiaInitial()) {
    on<FetchFraseDoDia>(_onFetchFraseDoDia);
  }

  void _onFetchFraseDoDia(FetchFraseDoDia event, Emitter<FraseDoDiaState> emit) async {
    emit(FraseDoDiaLoading());
    try {
      final frases = await repository.getFrasesEstoicas();
      // Assume que a lógica para selecionar uma frase diferente a cada dia já está implementada no repositório.
      emit(FraseDoDiaLoaded(frases[DateTime.now().day % frases.length]));
    } catch (e) {
      emit(FraseDoDiaError('Falha ao carregar a frase do dia.'));
    }
  }
}
