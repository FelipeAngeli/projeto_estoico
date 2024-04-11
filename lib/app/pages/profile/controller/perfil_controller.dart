import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_bloc.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_events.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController {
  final profileBloc = Modular.get<ProfileBloc>();

  void loadUserProfile() {
    profileBloc.add(LoadUserProfile());
  }

  Future<void> saveFrase(String novaFrase) async {
    final prefs = await SharedPreferences.getInstance();
    final frasesSalvas = prefs.getString('frasesSalvas') ?? '';
    final novasFrases = frasesSalvas.isEmpty ? novaFrase : '$frasesSalvas;$novaFrase';
    await prefs.setString('frasesSalvas', novasFrases);
  }

  Future<List<String>> loadFrases() async {
    final prefs = await SharedPreferences.getInstance();
    final frasesSalvas = prefs.getString('frasesSalvas') ?? '';
    return frasesSalvas.isNotEmpty ? frasesSalvas.split(';') : [];
  }
}
