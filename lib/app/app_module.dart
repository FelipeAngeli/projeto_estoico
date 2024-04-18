import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/modules/frase/bloc/frasedodia_bloc.dart';
import 'package:projeto_estoico/app/modules/login/bloc/login/login_bloc.dart';
import 'package:projeto_estoico/app/modules/login/bloc/register/register_bloc.dart';
import 'package:projeto_estoico/app/modules/search/bloc/search_bloc.dart';
import 'package:projeto_estoico/app/modules/profile/blocs/profile/profile_bloc.dart';
import 'package:projeto_estoico/app/modules/profile/blocs/settings/settings_bloc.dart';
import 'package:projeto_estoico/app/data/provider/estosicimo_provider.dart';
import 'package:projeto_estoico/app/data/repository/estoicismo_repoitory.dart';
import 'package:projeto_estoico/app/data/repository/profile_repository.dart';
import 'package:projeto_estoico/app/modules/frase/frase_module.dart';
import 'package:projeto_estoico/app/modules/login/login_module.dart';
import 'package:projeto_estoico/app/modules/profile/profile_module.dart';
import 'package:projeto_estoico/app/modules/search/search_module.dart';
import 'package:projeto_estoico/app/modules/splash/splash_page.dart';

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

    i.add<FraseDoDiaBloc>(() => FraseDoDiaBloc(
          Modular.get<EstoicismoRepository>(),
        ));
    i.add<RegisterBloc>(RegisterBloc.new);

    i.add<SettingsBloc>(() => SettingsBloc());
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const SplashPage());
    r.module(Modular.initialRoute, module: LoginModule());
    r.module(Modular.initialRoute, module: SearchModule());
    r.module(Modular.initialRoute, module: FraseModule());
    r.module(Modular.initialRoute, module: ProfileModule());
  }
}
