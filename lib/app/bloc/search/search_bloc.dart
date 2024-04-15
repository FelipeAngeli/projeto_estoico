import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/bloc/search/search_event.dart';
import 'package:projeto_estoico/app/bloc/search/search_state.dart';
import 'package:projeto_estoico/app/data/repository/estoicismo_repoitory.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final EstoicismoRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<StartSearch>(_onStartSearch);
  }

  Future<void> _onStartSearch(StartSearch event, Emitter<SearchState> emit) async {
    print('Iniciando busca por: ${event.query}');
    emit(SearchLoading());
    try {
      final frases = await repository.getFrasesEstoicas(query: event.query);
      if (frases.isEmpty) {
        emit(SearchEmpty());
        print('Nenhuma frase encontrada para a busca.');
      } else {
        emit(SearchLoaded(frases));
        print('Busca concluída com sucesso, frases carregadas: ${frases.length}');
      }
    } catch (error) {
      emit(SearchError(error.toString()));
      print('Erro na busca: ${error.toString()}');
    }
  }
}

// class SearchBloc extends Bloc<SearchEvent, SearchState> {
//   final EstoicismoRepository repository;
//   String currentQuery = '';

//   SearchBloc(this.repository) : super(SearchInitial()) {
//     on<StartSearch>(_onStartSearch);
//     on<SearchTextChanged>(_onSearchTextChanged);
//   }

//   void _onStartSearch(StartSearch event, Emitter<SearchState> emit) async {
//     emit(SearchLoading());
//     try {
//       final frases = await repository.getFrasesEstoicas(query: event.query);
//       if (frases.isEmpty) {
//         emit(SearchEmpty());
//         currentQuery = event.query;
//       } else {
//         emit(SearchLoaded(frases));
//       }
//     } catch (e) {
//       emit(SearchError("Erro ao buscar frases"));
//     }
//   }

//   // Definir o manipulador para SearchTextChanged
//   void _onSearchTextChanged(SearchTextChanged event, Emitter<SearchState> emit) async {
//     // Sua lógica para tratar o evento SearchTextChanged aqui
//   }
// }
