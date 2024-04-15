import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/bloc/search/search_bloc.dart';
import 'package:projeto_estoico/app/bloc/search/search_event.dart';

class SearchController {
  final SearchBloc searchBloc;
  final TextEditingController searchController = TextEditingController();

  SearchController(this.searchBloc);

  void search() {
    final String searchText = searchController.text.trim();
    if (searchText.isNotEmpty) {
      searchBloc.add(StartSearch(searchText));
    }
  }

  void dispose() {
    searchController.dispose();
  }
}

// class SearchController {
//   final SearchBloc searchBloc;
//   final TextEditingController searchController = TextEditingController();

//   SearchController(this.searchBloc) {
//     // Ouvinte agora apenas prepara o ambiente para uma busca, mas não inicia
//     searchController.addListener(_onSearchReady);
//   }

//   void _onSearchReady() {
//     // Essa função pode ser usada para ativar/desativar o botão de busca baseado no conteúdo do texto
//     if (searchController.text.isEmpty) {
//       // Desabilitar botão de busca se necessário
//     } else {
//       // Habilitar botão de busca se necessário
//     }
//   }

//   void search() {
//     final String searchText = searchController.text;
//     if (searchText.isNotEmpty) {
//       searchBloc.add(StartSearch(searchText));
//     }
//   }

//   void dispose() {
//     searchController.removeListener(_onSearchReady);
//     searchController.dispose();
//   }
// }
