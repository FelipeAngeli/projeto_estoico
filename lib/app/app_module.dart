import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/data/provider/estosicimo_provider.dart';
import 'package:projeto_estoico/app/data/repository/estoicismo_repoitory.dart';
import 'package:projeto_estoico/app/pages/frase_dia_page.dart';
import 'package:projeto_estoico/app/pages/home_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.add<EstoicismoProvider>(EstoicismoProvider.new);
    i.add<EstoicismoRepository>(EstoicismoRepository.new);
    i.add<EstoicismoBloc>(EstoicismoBloc.new);
  }

  // final List<Bind> binds = [
  //   Bind.lazySingleton((i) => EstoicismoProvider()),
  //   Bind.lazySingleton((i) => EstoicismoRepository(i())),
  //   Bind.lazySingleton((i) => EstoicismoBloc(repository: i())),
  // ];

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage());
    r.child('/frase_dia', child: (context) => FraseDoDiaPage());
  }
}
