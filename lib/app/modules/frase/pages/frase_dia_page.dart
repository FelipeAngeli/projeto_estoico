import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:projeto_estoico/app/modules/frase/bloc/frasedodia_bloc.dart';
import 'package:projeto_estoico/app/modules/frase/bloc/frasedodia_events.dart';
import 'package:projeto_estoico/app/modules/frase/bloc/frasedodia_states.dart';
import 'package:projeto_estoico/app/shared/widgets/app_bar_custom.dart';
import 'package:projeto_estoico/app/shared/widgets/bottom_bar_custom.dart';
import 'package:projeto_estoico/app/shared/widgets/card_frase_dia_custom.dart';
import 'package:projeto_estoico/app/shared/widgets/social_share_btn.dart';
import 'package:projeto_estoico/app/utils/color_custom.dart';

class FrasesDoDiaPage extends StatefulWidget {
  const FrasesDoDiaPage({super.key});

  @override
  _FrasesDoDiaPageState createState() => _FrasesDoDiaPageState();
}

class _FrasesDoDiaPageState extends State<FrasesDoDiaPage> {
  late FraseDoDiaBloc fraseDoDiaBloc;
  bool _isFraseSalva = false;

  @override
  void initState() {
    super.initState();
    fraseDoDiaBloc = Modular.get<FraseDoDiaBloc>();
    fraseDoDiaBloc.add(FetchFraseDoDia());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Frase do Dia',
        actions: [
          BlocBuilder<FraseDoDiaBloc, FraseDoDiaState>(
            bloc: fraseDoDiaBloc,
            builder: (context, state) {
              List<Widget> actions = [];
              if (state is FraseDoDiaLoaded) {
                actions.add(IconButton(
                  icon: Icon(
                    _isFraseSalva ? Icons.favorite : Icons.favorite_border,
                    color: _isFraseSalva ? Colors.red : ColorCustom.verde,
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      _isFraseSalva = !_isFraseSalva;
                      if (_isFraseSalva) {
                        fraseDoDiaBloc.salvarFrases(state.fraseDoDia);
                      }
                    });
                  },
                ));
                actions.add(SocialShareButton(textToShare: 'Frase do Dia: "${state.fraseDoDia.frase}"'));
              }
              return Row(children: actions);
            },
          ),
        ],
      ),
      body: BlocBuilder<FraseDoDiaBloc, FraseDoDiaState>(
        bloc: fraseDoDiaBloc,
        builder: (context, state) {
          if (state is FraseDoDiaLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FraseDoDiaLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CardFraseDiaCustom(
                      frase: state.fraseDoDia.frase,
                      autor: state.fraseDoDia.autor,
                    ),
                  ]),
            );
          }
          if (state is FraseDoDiaError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Nenhuma frase disponível'));
        },
      ),
      bottomNavigationBar: const BottomBarCustom(),
    );
  }
}

// class FrasesDoDiaPage extends StatefulWidget {
//   const FrasesDoDiaPage({super.key});

//   @override
//   _FrasesDoDiaPageState createState() => _FrasesDoDiaPageState();
// }

// class _FrasesDoDiaPageState extends State<FrasesDoDiaPage> {
//   late FrasesDoDiaController controller;
//   late FraseDoDiaBloc fraseDoDiaBloc;
//   bool _isFraseSalva = false; // Mantenha esta definição

//   @override
//   void initState() {
//     super.initState();
//     fraseDoDiaBloc = Modular.get<FraseDoDiaBloc>();
//     controller = FrasesDoDiaController(estoicismoBloc: fraseDoDiaBloc);
//     fraseDoDiaBloc.add(FetchFraseDoDia());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Frase do Dia',
//         actions: [
//           BlocBuilder<FraseDoDiaBloc, FraseDoDiaState>(
//             bloc: fraseDoDiaBloc,
//             builder: (context, state) {
//               List<Widget> actions = [];
//               if (state is FraseDoDiaLoaded) {
//                 actions.add(IconButton(
//                   icon: Icon(
//                     _isFraseSalva ? Icons.favorite : Icons.favorite_border,
//                     color: _isFraseSalva ? Colors.red : CustomColor.verde,
//                     size: 24,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _isFraseSalva = !_isFraseSalva;
//                       if (_isFraseSalva) {
//                         controller.salvarFrases(state.fraseDoDia);
//                       }
//                     });
//                   },
//                 ));
//                 actions.add(SocialShareButton(textToShare: 'Frase do Dia: "${state.fraseDoDia.frase}"'));
//               }
//               return Row(children: actions);
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<FraseDoDiaBloc, FraseDoDiaState>(
//         bloc: fraseDoDiaBloc,
//         builder: (context, state) {
//           if (state is FraseDoDiaLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state is FraseDoDiaLoaded) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: _buildLoadedState(state),
//             );
//           }
//           if (state is FraseDoDiaError) {
//             return Center(child: Text(state.message));
//           }
//           return const Center(child: Text('Nenhuma frase disponível'));
//         },
//       ),
//       bottomNavigationBar: const BottomBarCustom(),
//     );
//   }

//   Widget _buildLoadedState(FraseDoDiaLoaded state) {
//     return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CardFraseDiaCustom(
//             frase: state.fraseDoDia.frase,
//             autor: state.fraseDoDia.autor,
//           ),
//         ]);
//   }
// }
