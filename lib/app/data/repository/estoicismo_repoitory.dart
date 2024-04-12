import 'package:projeto_estoico/app/data/provider/estosicimo_provider.dart';
import 'package:projeto_estoico/app/models/estoicimsmo_model.dart';
import 'package:projeto_estoico/app/utils/app_error.dart';

class EstoicismoRepository {
  final EstoicismoProvider provider;
  List<EstoicismoModel> _cache = [];

  EstoicismoRepository(this.provider) {
    _initCache();
  }

  // Inicializa o cache com dados carregados do provider
  void _initCache() async {
    _cache = await provider.loadFrasesEstoicas();
  }

  // Obtém as frases, possivelmente filtradas por uma query
  Future<List<EstoicismoModel>> getFrasesEstoicas({String query = ''}) async {
    try {
      // Se não há query, retorna o cache
      if (query.isEmpty) {
        return _cache;
      } else {
        // Filtra o cache baseado na query e retorna os resultados
        return _cache.where((frase) => frase.frase.toLowerCase().contains(query.toLowerCase())).toList();
      }
    } catch (e) {
      throw AppError(message: 'Falha ao carregar as frases estoicas', code: ErrorCode.network);
    }
  }
}
// class EstoicismoRepository {
//   final EstoicismoProvider provider;

//   EstoicismoRepository(this.provider);

//   Future<List<EstoicismoModel>> getFrasesEstoicas({String query = ''}) async {
//     try {
//       final frases = await provider.loadFrasesEstoicas();
//       if (query.isEmpty) {
//         return frases;
//       } else {
//         return frases.where((frase) => frase.frase.toLowerCase().contains(query.toLowerCase())).toList();
//       }
//     } catch (e) {
//       throw AppError(message: 'Falha ao carregar as frases estoicas', code: ErrorCode.network);
//     }
//   }
// }
