import 'package:flutter_modular/flutter_modular.dart';
import 'modules/game/game_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    // Global bindings can be added here
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: GameModule());
  }
}
