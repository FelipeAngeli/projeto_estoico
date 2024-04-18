import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/modules/frase/bloc/frasedodia_events.dart';
import 'package:projeto_estoico/app/modules/frase/bloc/frasedodia_states.dart';
import 'package:projeto_estoico/app/data/repository/estoicismo_repoitory.dart';
import 'package:projeto_estoico/app/models/estoicimsmo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FraseDoDiaBloc extends Bloc<FraseDoDiaEvent, FraseDoDiaState> {
  final EstoicismoRepository repository;

  FraseDoDiaBloc(this.repository) : super(FraseDoDiaInitial()) {
    on<FetchFraseDoDia>(_onFetchFraseDoDia);
  }

  void _onFetchFraseDoDia(FetchFraseDoDia event, Emitter<FraseDoDiaState> emit) async {
    emit(FraseDoDiaLoading());
    try {
      final frases = await repository.getFrasesEstoicas();
      emit(FraseDoDiaLoaded(frases[DateTime.now().day % frases.length]));
    } catch (e) {
      emit(FraseDoDiaError('Falha ao carregar a frase do dia.'));
    }
  }

  Future<void> salvarFrases(EstoicismoModel frase) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> frasesSalvas = [frase.frase];
    await prefs.setStringList("frasesDoDia", frasesSalvas);
    print('Frase salva: ${frasesSalvas.toString()}');
  }

  Future<EstoicismoModel?> carregarFraseSalva() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? fraseSalva = prefs.getString('fraseDoDia');
    if (fraseSalva != null) {
      final partes = fraseSalva.split(' - ');
      if (partes.length >= 2) {
        return EstoicismoModel(frase: partes[0], autor: partes[1], imagem: '');
      }
    }
    return null;
  }
}
// class FraseDoDiaBloc extends Bloc<FraseDoDiaEvent, FraseDoDiaState> {
//   final EstoicismoRepository repository;

//   FraseDoDiaBloc(this.repository) : super(FraseDoDiaInitial()) {
//     on<FetchFraseDoDia>(_onFetchFraseDoDia);
//   }

//   void _onFetchFraseDoDia(FetchFraseDoDia event, Emitter<FraseDoDiaState> emit) async {
//     emit(FraseDoDiaLoading());
//     try {
//       final frases = await repository.getFrasesEstoicas();
//       // Assume que a lógica para selecionar uma frase diferente a cada dia já está implementada no repositório.
//       emit(FraseDoDiaLoaded(frases[DateTime.now().day % frases.length]));
//     } catch (e) {
//       emit(FraseDoDiaError('Falha ao carregar a frase do dia.'));
//     }
//   }
// }
