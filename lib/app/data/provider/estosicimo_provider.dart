import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:projeto_estoico/app/models/estoicimsmo_model.dart';

class EstoicismoProvider {
  Future<List<EstoicismoModel>> loadFrasesEstoicas() async {
    final String data = await rootBundle.loadString('assets/estoicismo.json');
    final List<dynamic> jsonData = json.decode(data)['estoicismo'];

    return jsonData.map((item) => EstoicismoModel.fromJson(item)).toList();
  }
}
