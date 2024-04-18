import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/modules/search/pages/search_page.dart';

class SearchModule extends Module {
  static const String search = '/search';
  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(search, child: (context) => const SearchPage(), transition: TransitionType.fadeIn);
  }
}
