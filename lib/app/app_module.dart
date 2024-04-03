import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/data/provider/estosicimo_provider.dart';
import 'package:projeto_estoico/app/data/repository/estoicismo_repoitory.dart';
import 'package:projeto_estoico/app/pages/frase/controller/frase_controller.dart';
import 'package:projeto_estoico/app/pages/frase/frase_dia_page.dart';
import 'package:projeto_estoico/app/pages/home/controller/home_controller.dart';
import 'package:projeto_estoico/app/pages/home/home_page.dart';
import 'package:projeto_estoico/app/pages/splash/splash_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.add<EstoicismoProvider>(EstoicismoProvider.new);
    i.add<EstoicismoRepository>(EstoicismoRepository.new);
    i.add<EstoicismoBloc>(EstoicismoBloc.new);
    i.add<HomeController>(() => HomeController());
    i.add<FraseDoDiaController>(() => FraseDoDiaController());
  }

  // final List<Bind> binds = [
  //   Bind.lazySingleton((i) => EstoicismoProvider()),
  //   Bind.lazySingleton((i) => EstoicismoRepository(i())),
  //   Bind.lazySingleton((i) => EstoicismoBloc(repository: i())),
  // ];

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const SplashPage());
    r.child('/home', child: (context) => const HomePage());
    r.child('/fraseDia', child: (context) => const FraseDoDiaPage());
  }
}
