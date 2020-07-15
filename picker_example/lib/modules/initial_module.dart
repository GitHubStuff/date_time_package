import 'package:flutter_modular/flutter_modular.dart';
import '../resources/constants.dart' as Constants;
import '../modular/app_widget.dart';
import 'initial_screen.dart';

class InitialModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router(Constants.initalRoute, child: (_, args) => InitialScreen()),
      ];

  static Inject get to => Inject<AppWidget>.of();
}
