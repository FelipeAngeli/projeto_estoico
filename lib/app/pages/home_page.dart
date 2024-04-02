import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_event.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_state.dart';
import 'package:projeto_estoico/app/model/estoicimsmo_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Disparando o evento para carregar as frases estoicas assim que o widget é construído
    context.read<EstoicismoBloc>().add(LoadEstoicismo());

    return Scaffold(
      appBar: AppBar(
        title: Text('Frases Estoicas'),
      ),
      body: BlocBuilder<EstoicismoBloc, EstoicismoState>(
        builder: (context, state) {
          if (state is EstoicismoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EstoicismoLoaded) {
            return ListView.builder(
              itemCount: state.frases.length,
              itemBuilder: (context, index) {
                EstoicismoModel frase = state.frases[index];
                return ListTile(
                  title: Text(frase.frase),
                  subtitle: Text(frase.autor),
                  // Aqui você pode adicionar a imagem do autor se disponível
                );
              },
            );
          } else if (state is EstoicismoError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(child: Text('Estado desconhecido'));
          }
        },
      ),
    );
  }
}
