import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/pages/login/pages/login_page.dart';
import 'package:projeto_estoico/app/pages/login/pages/register_page.dart';

class LoginModule extends Module {
  static const String login = '/login';
  static const String register = '/register';
  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(login, child: (context) => const LoginPage(), transition: TransitionType.scale);
    r.child(register, child: (context) => const RegisterPage(), transition: TransitionType.rightToLeft);
  }
}
