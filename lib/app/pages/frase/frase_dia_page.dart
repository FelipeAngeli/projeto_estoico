import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/estoicimsmo/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicimsmo/estoicismo_event.dart';
import 'package:projeto_estoico/app/bloc/estoicimsmo/estoicismo_state.dart';
import 'package:projeto_estoico/app/models/estoicimsmo_model.dart';
import 'package:projeto_estoico/app/pages/frase/controller/frase_controller.dart';
import 'package:projeto_estoico/app/utils/components/app_bar_custom.dart';
import 'package:projeto_estoico/app/utils/components/bottom_bar_custom.dart';
import 'package:projeto_estoico/app/utils/components/card_frase_dia_custom.dart';

class FraseDoDiaPage extends StatefulWidget {
  const FraseDoDiaPage({super.key});

  @override
  _FraseDoDiaPageState createState() => _FraseDoDiaPageState();
}

class _FraseDoDiaPageState extends State<FraseDoDiaPage> {
  final FraseDoDiaController controller = Modular.get<FraseDoDiaController>();
  final EstoicismoBloc estoicismoBloc = Modular.get<EstoicismoBloc>();

  @override
  void initState() {
    super.initState();
    estoicismoBloc.add(LoadEstoicismo());
    controller.loadFrasesEstoicas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: null,
          ),
        ],
      ),
      body: BlocConsumer<EstoicismoBloc, EstoicismoState>(
        bloc: controller.bloc,
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
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardFraseDiaCustom(
                    frase: fraseDoDia.frase,
                    autor: fraseDoDia.autor,
                  ),
                  // Text(
                  //   fraseDoDia.frase,
                  //   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  //   textAlign: TextAlign.center,
                  // ),
                  // const SizedBox(height: 20),
                  // Text(
                  //   fraseDoDia.autor,
                  //   style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  //   textAlign: TextAlign.center,
                  // ),
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
      bottomNavigationBar: const BottomBarCustom(),
    );
  }
}
