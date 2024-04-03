import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_event.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_state.dart';
import 'package:projeto_estoico/app/pages/home/controller/home_controller.dart';
import 'package:projeto_estoico/app/utils/components/app_bar_custom.dart';
import 'package:projeto_estoico/app/utils/components/bottom_bar_custom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Modular.get<HomeController>();

  @override
  void initState() {
    super.initState();
    controller.estoicismoBloc.add(LoadEstoicismo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<EstoicismoBloc, EstoicismoState>(
        bloc: controller.estoicismoBloc,
        builder: (context, state) {
          if (state is EstoicismoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EstoicismoLoaded) {
            return ListView.builder(
              itemCount: state.frases.length,
              itemBuilder: (context, index) {
                var frase = state.frases[index];
                return ListTile(
                  title: Text(frase.frase),
                  subtitle: Text(frase.autor),
                  // Aqui você pode adicionar a imagem do autor se disponível
                );
              },
            );
          } else if (state is EstoicismoError) {
            return Center(child: Text(state.message));
          }

          // Retorno padrão para qualquer outro estado que não seja tratado acima
          return const Center(child: Text('Estado desconhecido'));
        },
      ),
      bottomNavigationBar: const BottomBarCustom(),
    );
  }
}
