import 'package:projeto_estoico/app/data/provider/estosicimo_provider.dart';
import 'package:projeto_estoico/app/models/estoicimsmo_model.dart';
import 'package:projeto_estoico/app/utils/app_error.dart';

class EstoicismoRepository {
  final EstoicismoProvider provider;

  EstoicismoRepository(this.provider);

  Future<List<EstoicismoModel>> getFrasesEstoicas({String query = ''}) async {
    try {
      final frases = await provider.loadFrasesEstoicas();
      if (query.isEmpty) {
        return frases;
      } else {
        return frases.where((frase) => frase.frase.toLowerCase().contains(query.toLowerCase())).toList();
      }
    } catch (e) {
      throw AppError(message: 'Falha ao carregar as frases estoicas', code: ErrorCode.network);
    }
  }
}
