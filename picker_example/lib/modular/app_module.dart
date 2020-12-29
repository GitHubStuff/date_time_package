import 'package:date_time_package/picker/models/picker_modular/picker_modular_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart' as M;

import '../resources/constants.dart' as Constants;
import '../modules/initial_module.dart';
import 'app_bloc.dart';
import 'app_widget.dart';

class AppModule extends M.MainModule {
  @override
  List<M.Bind> get binds => [
        M.Bind((i) => AppBloc()),
        M.Bind((i) => PickerModularBloc()),
      ];

  @override
  List<M.Router> get routers => [
        M.Router(
          Constants.initalRoute,
          module: InitialModule(),
        ),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
