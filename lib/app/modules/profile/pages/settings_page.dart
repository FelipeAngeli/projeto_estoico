import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/modules/profile/blocs/settings/settings_bloc.dart';
import 'package:projeto_estoico/app/modules/profile/blocs/settings/settings_event.dart';
import 'package:projeto_estoico/app/modules/profile/blocs/settings/settings_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsBloc settingsBloc;

  @override
  void initState() {
    super.initState();
    settingsBloc = Modular.get<SettingsBloc>();
    settingsBloc.add(LoadUserSettings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        bloc: settingsBloc,
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SettingsLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: state.nameController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: state.emailController,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: state.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    settingsBloc.add(UpdateUserSettings(
                        state.nameController.text, state.emailController.text, state.passwordController.text));
                  },
                  child: const Text('Salvar Alterações'),
                )
              ],
            );
          } else if (state is SettingsError) {
            return Center(child: Text(state.error));
          }
          return const Center(child: Text('Nenhuma configuração disponível'));
        },
      ),
    );
  }

  @override
  void dispose() {
    settingsBloc.close();
    super.dispose();
  }
}
