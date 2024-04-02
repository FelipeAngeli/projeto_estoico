import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/data/provider/estosicimo_provider.dart';
import 'package:projeto_estoico/app/data/repository/estoicismo_repoitory.dart';
import 'package:projeto_estoico/app/pages/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final estoicismoRepository = EstoicismoRepository(EstoicismoProvider());

    return MaterialApp(
      title: 'Frases Estoicas',
      home: BlocProvider(
        create: (context) => EstoicismoBloc(repository: estoicismoRepository),
        child: HomePage(),
      ),
    );
  }
}
