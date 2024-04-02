class EstoicismoModel {
  final String frase;
  final String autor;
  final String imagem;

  EstoicismoModel({required this.frase, required this.autor, required this.imagem});

  factory EstoicismoModel.fromJson(Map<String, dynamic> json) {
    return EstoicismoModel(
      frase: json['frase'],
      autor: json['autor'],
      imagem: json['imagem'],
    );
  }
}
