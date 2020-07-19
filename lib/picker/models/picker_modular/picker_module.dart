import 'package:flutter_modular/flutter_modular.dart';

class PickerModule extends ChildModule {
  static Inject get to => Inject<PickerModule>.of();

  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [];
}
