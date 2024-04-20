import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/modules/login/pages/login_page.dart';
import 'package:projeto_estoico/app/modules/login/pages/register_email_page.dart';
import 'package:projeto_estoico/app/modules/login/pages/register_password_page.dart';

class LoginModule extends Module {
  static const String login = '/login';
  static const String registerEmail = '/registerEmail';
  static const String registerPassword = '/registerPassword';
  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(login, child: (context) => const LoginPage(), transition: TransitionType.scale);
    r.child(registerEmail, child: (context) => const RegisterEmailPage(), transition: TransitionType.rightToLeft);
    r.child(registerPassword, child: (context) => const RegisterPasswordPage(), transition: TransitionType.rightToLeft);
  }
}
