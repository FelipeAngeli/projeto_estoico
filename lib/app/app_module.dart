import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/frasedodia/frasedodia_bloc.dart';
import 'package:projeto_estoico/app/bloc/login/login_bloc.dart';
import 'package:projeto_estoico/app/bloc/register/register_bloc.dart';
import 'package:projeto_estoico/app/bloc/search/search_bloc.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_bloc.dart';
import 'package:projeto_estoico/app/bloc/settings/settings_bloc.dart';
import 'package:projeto_estoico/app/data/provider/estosicimo_provider.dart';
import 'package:projeto_estoico/app/data/repository/estoicismo_repoitory.dart';
import 'package:projeto_estoico/app/data/repository/profile_repository.dart';
import 'package:projeto_estoico/app/pages/frase/controller/frase_controller.dart';
import 'package:projeto_estoico/app/pages/frase/frase_dia_page.dart';
import 'package:projeto_estoico/app/pages/login/login_module.dart';
import 'package:projeto_estoico/app/pages/profile/settings_page.dart';
import 'package:projeto_estoico/app/pages/search/controller/search_controller.dart';
import 'package:projeto_estoico/app/pages/search/search_page.dart';
import 'package:projeto_estoico/app/pages/login/controller/login_controller.dart';
import 'package:projeto_estoico/app/pages/login/login_page.dart';
import 'package:projeto_estoico/app/pages/profile/controller/perfil_controller.dart';
import 'package:projeto_estoico/app/pages/profile/profile_page.dart';
import 'package:projeto_estoico/app/pages/register/controller/register_controller.dart';
import 'package:projeto_estoico/app/pages/register/register_page.dart';
import 'package:projeto_estoico/app/pages/splash/splash_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // Instâncias Singleton Diretas
    i.addInstance(FirebaseAuth.instance);

    // Providers e Repositórios
    i.add<BlocProvider>(BlocProvider.new);
    i.addLazySingleton<EstoicismoProvider>(() => EstoicismoProvider());
    i.addLazySingleton<ProfileRepository>(() => ProfileRepository());
    i.addLazySingleton<EstoicismoRepository>(() => EstoicismoRepository(
          Modular.get<EstoicismoProvider>(),
        ));

    //bloc
    i.add<LoginBloc>(LoginBloc.new);
    i.add<ProfileBloc>(ProfileBloc.new);
    i.add<SearchBloc>(() => SearchBloc(
          Modular.get<EstoicismoRepository>(),
        ));

    i.add<FraseDoDiaBloc>(FraseDoDiaBloc.new);
    i.add<RegisterBloc>(RegisterBloc.new);

    i.add<SettingsBloc>(() => SettingsBloc());

    // Controllers
    i.addLazySingleton<LoginController>(() => LoginController(
          Modular.get<LoginBloc>(),
        ));
    i.addLazySingleton<SearchController>(() => SearchController(
          Modular.get<SearchBloc>(),
        ));
    i.addLazySingleton<FrasesDoDiaController>(() => FrasesDoDiaController(
          estoicismoBloc: Modular.get<FraseDoDiaBloc>(),
        ));
    i.addLazySingleton<RegisterController>(() => RegisterController());
    i.addLazySingleton<ProfileController>(() => ProfileController());
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const SplashPage());

    r.module('/login', module: LoginModule());
    r.child('/register', child: (context) => const RegisterPage());
    r.child('/search', child: (context) => const SearchPage());
    r.child('/fraseDia', child: (context) => const FrasesDoDiaPage());
    r.child('/profile', child: (context) => const ProfilePage());
    r.child('/settings', child: (context) => SettingsPage());
  }
}
