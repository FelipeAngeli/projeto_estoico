import 'package:projeto_estoico/app/data/provider/estosicimo_provider.dart';
import 'package:projeto_estoico/app/model/estoicimsmo_model.dart';
import 'package:projeto_estoico/app/utils/app_error.dart';

class EstoicismoRepository {
  final EstoicismoProvider provider;

  EstoicismoRepository(this.provider);

  Future<List<EstoicismoModel>> getFrasesEstoicas() async {
    try {
      return await provider.loadFrasesEstoicas();
    } catch (e) {
      throw AppError(message: 'Falha ao carregar as frases estoicas', code: ErrorCode.network);
    }
  }
}
