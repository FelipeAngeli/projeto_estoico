import 'package:projeto_estoico/app/core/models/estoicimsmo_model.dart';

abstract class FraseDoDiaEvent {}

class FetchFraseDoDia extends FraseDoDiaEvent {}

class SaveFraseDoDia extends FraseDoDiaEvent {
  final EstoicismoModel frase;

  SaveFraseDoDia(this.frase);
}

class LoadSavedFrase extends FraseDoDiaEvent {}
