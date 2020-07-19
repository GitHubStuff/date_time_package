import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../date_time_package.dart';
import 'event/event_bloc.dart';

class PickerModularBloc extends Disposable {
  DateTimeEvent dateTimeEvent;
  PickerModularBloc({@required this.dateTimeEvent});

  final EventBloc eventBloc = EventBloc();

  final StreamController streamController = StreamController<DateTime>.broadcast();
  final pickerHeight = 220.0;
  final pickerWidth = 280.0;

  @override
  void dispose() {
    streamController.close();
  }
}
