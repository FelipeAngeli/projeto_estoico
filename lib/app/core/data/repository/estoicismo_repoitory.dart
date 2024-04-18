import 'package:projeto_estoico/app/core/data/provider/estosicimo_provider.dart';
import 'package:projeto_estoico/app/core/models/estoicimsmo_model.dart';

class EstoicismoRepository {
  final EstoicismoProvider provider; // Seu provedor de dados
  List<EstoicismoModel> _cache = []; // Cache local das frases

  EstoicismoRepository(this.provider) {
    _initCache();
  }

  Future<void> _initCache() async {
    _cache = await provider.loadFrasesEstoicas();
    print('Cache inicializado com ${_cache.length} frases.');
  }

  Future<List<EstoicismoModel>> getFrasesEstoicas({String query = ''}) async {
    print('Busca recebida: $query');
    if (query.isEmpty) {
      return _cache;
    } else {
      var normalizedQuery = query.toLowerCase().trim();
      var filtered = _cache
          .where((frase) =>
              frase.frase.toLowerCase().trim().contains(normalizedQuery) ||
              frase.autor.toLowerCase().trim().contains(normalizedQuery))
          .toList();
      print('Frases filtradas encontradas: ${filtered.length}');
      return filtered;
    }
  }
}
