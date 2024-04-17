import 'package:projeto_estoico/app/bloc/frasedodia/frasedodia_bloc.dart';

import 'package:projeto_estoico/app/models/estoicimsmo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FrasesDoDiaController {
  final FraseDoDiaBloc estoicismoBloc;

  FrasesDoDiaController({required this.estoicismoBloc});

  Future<void> salvarFrases(EstoicismoModel frase) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> frasesSalvas = [];
    frasesSalvas.add(frase.frase);
    await prefs.setStringList("frasesDoDia", frasesSalvas);
    print('Frase salva: ${frasesSalvas.toString()}');
  }

  Future<EstoicismoModel?> carregarFraseSalva() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? fraseSalva = prefs.getString('fraseDoDia');
    if (fraseSalva != null) {
      final partes = fraseSalva.split(' - ');
      if (partes.length >= 2) {
        return EstoicismoModel(frase: partes[0], autor: partes[1], imagem: '');
        // Note que a imagem não é salva neste exemplo. Você precisaria ajustar para salvar/recuperar a URL da imagem, se necessário.
      }
    }
    return null;
  }
}
