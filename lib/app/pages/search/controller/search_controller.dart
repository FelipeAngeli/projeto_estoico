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
