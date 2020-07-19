import 'package:date_time_package/date_time_package.dart';
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
        Bind((i) => DateTimeEvent()),
        Bind((i) => PickerModularBloc(dateTimeEvent: i.get())),
        // Bind((i) => AgreementBloc()),
        // Bind((i) => LocationBloc()),
        // Bind((i) => NetworkConnectionMonitor()..listen()),
        // Bind((i) => ServicesMetaRespository(
        //       url: FlavorConfig.instance.values.servicesUpdateListUrl,
        //     )),
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
