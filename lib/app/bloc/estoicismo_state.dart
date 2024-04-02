import 'package:projeto_estoico/app/model/estoicimsmo_model.dart';

abstract class EstoicismoState {}

class EstoicismoInitial extends EstoicismoState {}

class EstoicismoLoading extends EstoicismoState {}

class EstoicismoLoaded extends EstoicismoState {
  final List<EstoicismoModel> frases; // Substitua dynamic pelo seu modelo de dados
  EstoicismoLoaded(this.frases);
}

class EstoicismoError extends EstoicismoState {
  final String message;
  EstoicismoError(this.message);
}
