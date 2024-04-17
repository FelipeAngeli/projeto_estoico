import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/pages/login/page/login_page.dart';

class LoginModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(Modular.initialRoute, child: (context) => const LoginPage());
  }
}
