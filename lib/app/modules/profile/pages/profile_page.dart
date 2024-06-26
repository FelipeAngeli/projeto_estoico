import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/modules/profile/blocs/profile/profile_bloc.dart';
import 'package:projeto_estoico/app/modules/profile/blocs/profile/profile_events.dart';
import 'package:projeto_estoico/app/modules/profile/blocs/profile/profile_state.dart';
import 'package:projeto_estoico/app/shared/widgets/bottom_bar_custom.dart';

import 'package:projeto_estoico/app/utils/color_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final profileBloc = Modular.get<ProfileBloc>();

//   List<String> _fraseDoDia = [];

//   @override
//   void initState() {
//     super.initState();
//     profileBloc.add(LoadUserProfile());
//     profileBloc.add(LoadFrases());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<ProfileBloc>(
//       create: (_) => Modular.get<ProfileBloc>(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Perfil"),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.settings),
//               onPressed: () {
//                 Modular.to.pushNamed('/settings');
//               },
//               tooltip: 'Configurações',
//               color: CustomColor.verde,
//             ),
//           ],
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: BlocListener<ProfileBloc, ProfileState>(
//                 bloc: profileBloc,
//                 listener: (context, state) {
//                   if (state is FrasesLoaded) {
//                     setState(() {
//                       _fraseDoDia = state.frases;
//                     });
//                   }
//                 },
//                 child: BlocBuilder<ProfileBloc, ProfileState>(
//                   bloc: profileBloc,
//                   builder: (context, state) {
//                     if (state is ProfileLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (state is ProfileLoaded) {
//                       return _buildUserInfo(state);
//                     } else if (state is FrasesLoaded) {
//                       return ListView(
//                         children: state.frases.map((e) => Text(e)).toList(),
//                       );
//                     } else if (state is ProfileError) {
//                       return Center(child: Text(state.message));
//                     }
//                     return const Center(child: Text('Nenhum estado correspondente encontrado.'));
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: const BottomBarCustom(),
//       ),
//     );
//   }

//   Widget _buildUserInfo(ProfileLoaded state) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 32),
//           Center(
//             child: CircleAvatar(
//               radius: 50,
//               backgroundColor: CustomColor.verde,
//               backgroundImage: const AssetImage("assets/image/profile.jpeg"),
//             ),
//           ),
//           Text(state.user.email, textAlign: TextAlign.center),
//           const SizedBox(height: 32),
//           const Spacer(),
//           TextButton(
//               child: Text(
//                 "Sair do app",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: CustomColor.verde,
//                   fontSize: 16,
//                 ),
//               ),
//               onPressed: () async {
//                 await FirebaseAuth.instance.signOut();
//                 Modular.to.navigate('/login');
//               }),
//           const SizedBox(height: 32),
//         ],
//       ),
//     );
//   }
// }

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileBloc = Modular.get<ProfileBloc>();

  List<String> _fraseDoDia = [];

  @override
  void initState() {
    super.initState();
    profileBloc.add(LoadUserProfile());
    _carregarFraseDoDia();
  }

  void _carregarFraseDoDia() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final fraseSalva = prefs.getStringList('frasesDoDia') ?? [];
    setState(() {
      _fraseDoDia = fraseSalva;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (_) => Modular.get<ProfileBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Perfil"),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Modular.to.pushNamed('/settings');
              },
              tooltip: 'Configurações',
              color: ColorCustom.verde,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ProfileBloc, ProfileState>(
                bloc: profileBloc,
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProfileLoaded) {
                    return _buildUserInfo(state);
                  } else if (state is ProfileError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomBarCustom(),
      ),
    );
  }

  Widget _buildUserInfo(ProfileLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: ColorCustom.verde,
              backgroundImage: const AssetImage("assets/image/profile.jpeg"),
            ),
          ),
          Text(state.user.email, textAlign: TextAlign.center),
          const SizedBox(height: 32),
          const Spacer(),
          Text(
            "Frases favoritas:",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorCustom.preto,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView(
            shrinkWrap: true,
            children: _fraseDoDia.map((e) => Text(e)).toList(),
          ),
          const Spacer(),
          TextButton(
              child: Text(
                "Sair do app",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorCustom.verde,
                  fontSize: 16,
                ),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Modular.to.navigate('/login');
              }),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
