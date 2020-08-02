import 'package:date_time_package/picker/models/picker_modular/picker_modular_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_bloc.dart';

import '../resources/constants.dart' as Constants;
import '../modules/initial_module.dart';
import 'app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppBloc()),
        Bind((i) => PickerModularBloc()),
      ];

  @override
  List<Router> get routers => [
        Router(
          Constants.initalRoute,
          module: InitialModule(),
        ),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
