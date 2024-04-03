import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_event.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_state.dart';
import 'package:projeto_estoico/app/model/estoicimsmo_model.dart';

class FraseDoDiaPage extends StatefulWidget {
  const FraseDoDiaPage({super.key});

  @override
  _FraseDoDiaPageState createState() => _FraseDoDiaPageState();
}

class _FraseDoDiaPageState extends State<FraseDoDiaPage> {
  final EstoicismoBloc estoicismoBloc = Modular.get<EstoicismoBloc>();

  @override
  void initState() {
    super.initState();
    estoicismoBloc.add(LoadEstoicismo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frase do Dia'),
      ),
      body: BlocConsumer<EstoicismoBloc, EstoicismoState>(
        bloc: estoicismoBloc,
        listener: (context, state) {
          if (state is EstoicismoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is EstoicismoLoaded) {
            int diaDoAno = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
            EstoicismoModel fraseDoDia = state.frases[diaDoAno % state.frases.length];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fraseDoDia.frase,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    fraseDoDia.autor,
                    style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                  // Aqui você pode adicionar a imagem do autor se disponível
                ],
              ),
            );
          } else if (state is EstoicismoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // Inclui tanto EstoicismoError quanto o estado inicial/desconhecido
            return const Center(child: Text('Nenhuma frase disponível.'));
          }
        },
      ),
    );
  }
}
