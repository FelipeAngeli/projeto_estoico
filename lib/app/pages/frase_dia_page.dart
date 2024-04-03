import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_state.dart';
import 'package:projeto_estoico/app/model/estoicimsmo_model.dart';

class FraseDoDiaPage extends StatefulWidget {
  @override
  _FraseDoDiaPageState createState() => _FraseDoDiaPageState();
}

class _FraseDoDiaPageState extends State<FraseDoDiaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frase do Dia'),
      ),
      body: BlocBuilder<EstoicismoBloc, EstoicismoState>(
        builder: (context, state) {
          if (state is EstoicismoLoaded) {
            // Calculando o índice baseado na data atual
            int diaDoAno = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
            EstoicismoModel fraseDoDia = state.frases[diaDoAno % state.frases.length];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(fraseDoDia.frase, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text(fraseDoDia.autor, style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                  // Aqui você pode adicionar a imagem do autor se disponível
                ],
              ),
            );
          } else if (state is EstoicismoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EstoicismoError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Nenhuma frase disponível.'));
          }
        },
      ),
    );
  }
}
