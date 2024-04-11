import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/search/search_bloc.dart';
import 'package:projeto_estoico/app/bloc/search/search_event.dart';
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
    // Inicialização do SearchController com Modular.get para obter uma instância de SearchBloc
    controller = search_ctrl.SearchController(Modular.get<SearchBloc>());
  }

  @override
  void dispose() {
    // Garante que o controller seja descartado corretamente
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Pesquise pela frase"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      labelText: "Pesquisar",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: CustomColor.verde),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Inicia a pesquisa diretamente pelo SearchBloc
                    controller.searchBloc.add(StartSearch(controller.searchController.text));
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              bloc: controller.searchBloc,
              builder: (context, state) {
                if (state is SearchLoaded) {
                  if (state.frases.isEmpty) {
                    return Center(
                      child: Text(
                        'Nenhuma frase encontrada.',
                        style: TextStyle(color: CustomColor.verde),
                      ),
                    );
                  }
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
                }
                return Container();
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
//   // TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     controller = search_ctrl.SearchController(Modular.get<SearchBloc>());
//   }

//   @override
//   void dispose() {
//     //  _controller.dispose();
//     controller.dispose();
//     super.dispose();
//   }

//   // void _onSearch() {
//   //   // Chama o método de busca usando o valor atual do controller.searchController
//   //   controller.searchBloc.add(StartSearch(controller.searchController.text));
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(title: "Pesquise pela frase"),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: controller.searchController,
//                     // controller: _controller,
//                     decoration: InputDecoration(
//                       labelText: "Pesquisar",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25.0),
//                         borderSide: BorderSide(color: CustomColor.verde),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: () {
//                     // Aqui você chama diretamente o SearchBloc para adicionar o evento de início da pesquisa.
//                     // Isso permite iniciar a pesquisa explicitamente, independentemente da mudança de texto.
//                     controller.searchBloc.add(StartSearch(controller.searchController.text));
//                   },
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             child: BlocBuilder<SearchBloc, SearchState>(
//               bloc: controller.searchBloc,
//               builder: (context, state) {
//                 if (state is SearchLoaded) {
//                   if (state.frases.isEmpty) {
//                     return Center(
//                       child: Text(
//                         'Nenhuma frase encontrada.',
//                         style: TextStyle(color: CustomColor.verde),
//                       ),
//                     );
//                   }
//                   return ListView.builder(
//                     itemCount: state.frases.length,
//                     itemBuilder: (context, index) {
//                       var frase = state.frases[index];
//                       return ListTile(
//                         title: CardCustom(
//                           frase: frase.frase,
//                           autor: frase.autor,
//                         ),
//                       );
//                     },
//                   );
//                 }
//                 return Container();
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: const BottomBarCustom(),
//     );
//   }
// }


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
//     // controller = SearchController(); // Inicializa o controller
//     controller = search_ctrl.SearchController(Modular.get<SearchBloc>());
//   }

//   @override
//   void dispose() {
//     controller.dispose(); // Libera recursos quando a página é fechada
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
//             // Exibindo um indicador de carregamento enquanto a busca está sendo realizada
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is SearchLoaded) {
//             // Exibindo os resultados da busca
//             if (state.frases.isEmpty) {
//               // Caso não haja resultados para a busca
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
//             // Exibindo uma mensagem de erro caso algo dê errado durante a busca
//             return Center(
//               child: Text(
//                 state.message,
//                 style: TextStyle(color: CustomColor.verde),
//               ),
//             );
//           } else if (state is SearchInitial) {
//             // Estado inicial ou quando o usuário não digitou nada ainda
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
