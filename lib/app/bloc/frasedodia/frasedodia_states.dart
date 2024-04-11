import 'package:projeto_estoico/app/models/estoicimsmo_model.dart';

abstract class FraseDoDiaState {}

class FraseDoDiaInitial extends FraseDoDiaState {}

class FraseDoDiaLoading extends FraseDoDiaState {}

class FraseDoDiaLoaded extends FraseDoDiaState {
  final EstoicismoModel fraseDoDia;
  FraseDoDiaLoaded(this.fraseDoDia);
}

class FraseDoDiaError extends FraseDoDiaState {
  final String message;
  FraseDoDiaError(this.message);
}
// FraseDoDia