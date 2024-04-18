import 'package:projeto_estoico/app/models/estoicimsmo_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<EstoicismoModel> frases;
  SearchLoaded(this.frases);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

class SearchEmpty extends SearchState {}
