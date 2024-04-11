import 'package:projeto_estoico/app/bloc/frasedodia/frasedodia_bloc.dart';

import 'package:projeto_estoico/app/models/estoicimsmo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FrasesDoDiaController {
  final FraseDoDiaBloc estoicismoBloc;

  FrasesDoDiaController({required this.estoicismoBloc});

  Future<void> salvarFrase(EstoicismoModel frase) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fraseDoDia', '${frase.frase} - ${frase.autor}');
    print('Frase salva: ${frase.frase} - ${frase.autor}');
  }
  // Future<void> salvarFrase(EstoicismoModel frase) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // Aqui estamos salvando a frase e o autor como uma string única.
  //   await prefs.setString('fraseDoDia', '${frase.frase} - ${frase.autor}');
  //   print('Frase salva: ${frase.frase} - ${frase.autor}');
  // }

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
