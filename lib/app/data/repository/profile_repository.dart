import 'package:projeto_estoico/app/models/user_model.dart';

class ProfileRepository {
  Future<UserModel> fetchUserProfile() async {
    // Simulando uma chamada de rede ou banco de dados
    return UserModel(id: "1", name: "Felipe", email: "felipe@gmail.com");
  }

  Future<List<String>> fetchFrases() async {
    // Simulando uma chamada de rede ou banco de dados
    return ["Frase 1", "Frase 2", "Frase 3"];
  }
}
