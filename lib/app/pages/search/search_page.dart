import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/search/search_bloc.dart';
import 'package:projeto_estoico/app/bloc/search/search_state.dart';
import 'package:projeto_estoico/app/utils/components/app_bar_custom.dart';
import 'package:projeto_estoico/app/utils/components/bottom_bar_custom.dart';
import 'package:projeto_estoico/app/utils/components/card_custom.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';
import 'package:projeto_estoico/app/pages/search/controller/search_controller.dart' as search_ctrl;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final search_ctrl.SearchController controller;

  @override
  void initState() {
    super.initState();
    controller = search_ctrl.SearchController(Modular.get<SearchBloc>());
    print('SearchPage inicializada.');
  }

  @override
  void dispose() {
    controller.dispose();
    print('SearchPage descartada.');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Pesquise pela frase",
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                labelText: "Pesquisar",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    print('Botão de busca pressionado.');
                    controller.search();
                    controller.searchController.clear();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: CustomColor.verde),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              bloc: controller.searchBloc,
              builder: (context, state) {
                if (state is SearchLoading) {
                  print('Carregando...');
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchLoaded) {
                  print('Frases carregadas: ${state.frases.length}');
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
                  print('Erro: ${state.message}');
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: CustomColor.verde),
                    ),
                  );
                } else if (state is SearchInitial || state is SearchEmpty) {
                  print('Nenhum resultado encontrado ou estado inicial.');
                  return Center(
                    child: Text(
                      'Digite algo para iniciar a busca.',
                      style: TextStyle(color: CustomColor.verde),
                    ),
                  );
                }
                print('Estado desconhecido.');
                return const Center(child: Text('Estado desconhecido'));
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBarCustom(),
    );
  }
}
// class SearchPage extends StatefulWidget {
//   const SearchPage({Key? key}) : super(key: key);

//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   late final search_ctrl.SearchController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = search_ctrl.SearchController(Modular.get<SearchBloc>());
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: "Pesquise pela frase",
//       ),
//       body: BlocBuilder<SearchBloc, SearchState>(
//         bloc: controller.searchBloc,
//         builder: (context, state) {
//           if (state is SearchLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is SearchLoaded) {
//             if (state.frases.isEmpty) {
//               return Center(
//                 child: Text(
//                   'Nenhuma frase encontrada.',
//                   style: TextStyle(color: CustomColor.verde),
//                 ),
//               );
//             }
//             return ListView.builder(
//               itemCount: state.frases.length,
//               itemBuilder: (context, index) {
//                 var frase = state.frases[index];
//                 return ListTile(
//                   title: CardCustom(
//                     frase: frase.frase,
//                     autor: frase.autor,
//                   ),
//                 );
//               },
//             );
//           } else if (state is SearchError) {
//             return Center(
//               child: Text(
//                 state.message,
//                 style: TextStyle(color: CustomColor.verde),
//               ),
//             );
//           } else if (state is SearchInitial) {
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     controller: controller.searchController,
//                     decoration: InputDecoration(
//                       labelText: "Pesquisar",
//                       suffixIcon: IconButton(
//                         icon: const Icon(Icons.clear),
//                         onPressed: () {
//                           controller.searchController.clear();
//                         },
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25.0),
//                         borderSide: BorderSide(color: CustomColor.verde),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: BlocBuilder<SearchBloc, SearchState>(
//                     bloc: controller.searchBloc,
//                     builder: (context, state) {
//                       if (state is SearchLoaded) {
//                         if (state.frases.isEmpty) {
//                           return Center(
//                             child: Text(
//                               'Nenhuma frase encontrada.',
//                               style: TextStyle(color: CustomColor.verde),
//                             ),
//                           );
//                         }
//                         return ListView.builder(
//                           itemCount: state.frases.length,
//                           itemBuilder: (context, index) {
//                             var frase = state.frases[index];
//                             return ListTile(
//                               title: CardCustom(
//                                 frase: frase.frase,
//                                 autor: frase.autor,
//                               ),
//                             );
//                           },
//                         );
//                       }
//                       return Container();
//                     },
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             // Para qualquer outro estado não tratado especificamente
//             return const Center(child: Text('Estado desconhecido'));
//           }
//         },
//       ),
//       bottomNavigationBar: const BottomBarCustom(),
//     );
//   }
// }
