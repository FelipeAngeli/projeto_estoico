import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/modules/search/bloc/search_event.dart';
import 'package:projeto_estoico/app/modules/search/bloc/search_state.dart';
import 'package:projeto_estoico/app/data/repository/estoicismo_repoitory.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final EstoicismoRepository repository;
  final TextEditingController searchController = TextEditingController();

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<StartSearch>(_onStartSearch);

    searchController.addListener(() {
      final String searchText = searchController.text.trim();
      if (searchText.isNotEmpty) {
        add(StartSearch(searchText));
      }
    });
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

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
