import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/settings/settings_bloc.dart';
import 'package:projeto_estoico/app/bloc/settings/settings_event.dart';
import 'package:projeto_estoico/app/bloc/settings/settings_state.dart';
import 'package:projeto_estoico/app/pages/profile/controller/settings_controller.dart';

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
    settingsBloc.add(LoadUserSettings()); // Adicionando evento para carregar as configurações
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
                  initialValue: state.name,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: state.email,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: state.password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Logica para salvar as configurações
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
    super.dispose();
    settingsBloc.close();
  }
}
