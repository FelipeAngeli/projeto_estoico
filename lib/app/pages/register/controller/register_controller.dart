import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_event.dart';

class RegisterController {
  final EstoicismoBloc estoicismoBloc = Modular.get<EstoicismoBloc>();

  void loadFrasesEstoicas() {
    estoicismoBloc.add(LoadEstoicismo());
  }
}
