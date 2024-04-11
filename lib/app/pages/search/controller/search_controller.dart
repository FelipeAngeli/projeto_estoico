import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/bloc/search/search_bloc.dart';
import 'package:projeto_estoico/app/bloc/search/search_event.dart';

class SearchController {
  final SearchBloc _searchBloc;
  final TextEditingController searchController = TextEditingController();

  SearchController(this._searchBloc) {
    searchController.addListener(_onSearchChanged);
  }

  // Getter para expor o SearchBloc
  SearchBloc get searchBloc => _searchBloc;

  void _onSearchChanged() {
    _searchBloc.add(SearchTextChanged(searchController.text));
  }

  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
  }
}
