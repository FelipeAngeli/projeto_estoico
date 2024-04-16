import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_bloc.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_events.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_state.dart';
import 'package:projeto_estoico/app/utils/components/bottom_bar_custom.dart';
import 'package:projeto_estoico/app/utils/components/card_custom.dart';
import 'package:projeto_estoico/app/utils/components/card_frase_dia_custom.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileBloc = Modular.get<ProfileBloc>();

  String _fraseDoDia = "";

  @override
  void initState() {
    super.initState();
    profileBloc.add(LoadUserProfile());
    _carregarFraseDoDia();
  }

  void _carregarFraseDoDia() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Certifique-se de que a chave usada aqui corresponde exatamente à chave usada para salvar.
    final fraseSalva = prefs.getString('fraseDoDia') ?? "Nenhuma frase do dia salva.";
    setState(() {
      // Aqui você armazena a frase do dia carregada em uma variável da classe
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
                // Defina o que acontece quando o botão de configurações é pressionado
              },
              tooltip: 'Configurações',
              color: CustomColor.verde,
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
              backgroundColor: CustomColor.verde,
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
              color: CustomColor.preto,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView(shrinkWrap: true, children: [
            Text(_fraseDoDia),
            Text(_fraseDoDia),
          ]),
          const Spacer(),
          TextButton(
              child: Text(
                "Sair do app",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomColor.verde,
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
