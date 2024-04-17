import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/pages/profile/pages/profile_page.dart';
import 'package:projeto_estoico/app/pages/profile/pages/settings_page.dart';

class ProfileModule extends Module {
  static const String profile = '/profile';
  static const String settings = '/settings';
  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(profile, child: (context) => const ProfilePage(), transition: TransitionType.fadeIn);
    r.child(settings, child: (context) => const SettingsPage(), transition: TransitionType.rightToLeft);
  }
}
