import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/estoicimsmo/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicimsmo/estoicismo_event.dart';

class FraseDoDiaController {
  final EstoicismoBloc _estoicismoBloc = Modular.get<EstoicismoBloc>();

  void loadFrasesEstoicas() {
    _estoicismoBloc.add(LoadEstoicismo());
  }

  EstoicismoBloc get bloc => _estoicismoBloc;
}
