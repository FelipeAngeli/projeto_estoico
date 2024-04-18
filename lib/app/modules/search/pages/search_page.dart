import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/modules/search/bloc/search_bloc.dart';
import 'package:projeto_estoico/app/modules/search/bloc/search_state.dart';
import 'package:projeto_estoico/app/shared/widgets/app_bar_custom.dart';
import 'package:projeto_estoico/app/shared/widgets/bottom_bar_custom.dart';
import 'package:projeto_estoico/app/shared/widgets/card_custom.dart';
import 'package:projeto_estoico/app/utils/color_custom.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Pesquise pela frase"),
      body: BlocProvider<SearchBloc>(
        create: (context) => Modular.get<SearchBloc>(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
                var bloc = BlocProvider.of<SearchBloc>(context);
                return TextField(
                  controller: bloc.searchController,
                  decoration: InputDecoration(
                    labelText: "Pesquisar",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        bloc.searchController.clear(); // Limpa o campo após a pesquisa
                        print('Botão de busca pressionado.');
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: ColorCustom.verde),
                    ),
                  ),
                );
              }),
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    return ListView.builder(
                      itemCount: state.frases.length,
                      itemBuilder: (context, index) {
                        var frase = state.frases[index];
                        return ListTile(
                          title: CardCustom(
                            frase: frase.frase,
                            autor: frase.autor,
                          ),
                        );
                      },
                    );
                  } else if (state is SearchError) {
                    return Center(
                      child: Text(state.message, style: TextStyle(color: ColorCustom.verde)),
                    );
                  } else if (state is SearchInitial || state is SearchEmpty) {
                    return Center(
                      child: Text('Digite algo para iniciar a busca.', style: TextStyle(color: ColorCustom.verde)),
                    );
                  }
                  return const Center(child: Text('Estado desconhecido'));
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBarCustom(),
    );
  }
}
