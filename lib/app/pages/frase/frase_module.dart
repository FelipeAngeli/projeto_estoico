import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/pages/frase/pages/frase_dia_page.dart';

class FraseModule extends Module {
  static const String fraseDia = '/fraseDia';

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(fraseDia, child: (context) => const FrasesDoDiaPage(), transition: TransitionType.fadeIn);
  }
}
