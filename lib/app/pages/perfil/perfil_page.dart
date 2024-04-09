import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_bloc.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_state.dart';
import 'package:projeto_estoico/app/pages/perfil/controller/perfil_controller.dart';
import 'package:projeto_estoico/app/utils/components/bottom_bar_custom.dart';

class ProfilePage extends StatelessWidget {
  final controller = Modular.get<ProfileController>();

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => controller.profileBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text("Perfil")),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Nome: ${state.user.name}"),
                    Text("Email: ${state.user.email}"),
                  ],
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            }
            return Container(); // Estado inicial ou desconhecido
          },
        ),
        bottomNavigationBar: const BottomBarCustom(),
      ),
    );
  }
}
