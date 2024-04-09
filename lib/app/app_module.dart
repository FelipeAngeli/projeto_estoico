import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/estoicimsmo/estoicismo_bloc.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_bloc.dart';
import 'package:projeto_estoico/app/data/provider/estosicimo_provider.dart';
import 'package:projeto_estoico/app/data/repository/estoicismo_repoitory.dart';
import 'package:projeto_estoico/app/pages/frase/controller/frase_controller.dart';
import 'package:projeto_estoico/app/pages/frase/frase_dia_page.dart';
import 'package:projeto_estoico/app/pages/home/controller/home_controller.dart';
import 'package:projeto_estoico/app/pages/home/home_page.dart';
import 'package:projeto_estoico/app/pages/login/controller/login_controller.dart';
import 'package:projeto_estoico/app/pages/login/login_page.dart';
import 'package:projeto_estoico/app/pages/perfil/controller/perfil_controller.dart';
import 'package:projeto_estoico/app/pages/perfil/perfil_page.dart';
import 'package:projeto_estoico/app/pages/register/controller/register_controller.dart';
import 'package:projeto_estoico/app/pages/register/register_page.dart';
import 'package:projeto_estoico/app/pages/splash/splash_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.add<EstoicismoProvider>(EstoicismoProvider.new);
    i.add<EstoicismoRepository>(EstoicismoRepository.new);
    i.add<EstoicismoBloc>(EstoicismoBloc.new);
    i.add<LoginController>(() => LoginController());
    i.add<RegisterController>(() => RegisterController(
          onSucessLogin: () => {},
          onUpDate: () => {}, // Defina aqui o que você quer fazer no update
        ));
    i.add<HomeController>(() => HomeController());
    i.add<FraseDoDiaController>(() => FraseDoDiaController());
    i.addLazySingleton<ProfileBloc>(() => ProfileBloc());
    i.add<ProfileController>(() => ProfileController());
  }

  // final List<Bind> binds = [
  //   Bind.lazySingleton((i) => EstoicismoProvider()),
  //   Bind.lazySingleton((i) => EstoicismoRepository(i())),
  //   Bind.lazySingleton((i) => EstoicismoBloc(repository: i())),
  // ];

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const SplashPage());
    r.child('/login', child: (context) => const LoginPage());
    r.child('/register', child: (context) => const RegisterPage());
    r.child('/home', child: (context) => const HomePage());
    r.child('/fraseDia', child: (context) => const FraseDoDiaPage());
    r.child('/perfil', child: (context) => ProfilePage());
  }
}
