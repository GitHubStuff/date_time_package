import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../date_time_package.dart';

class PickerBloc extends Disposable {
  DateTimeEvent dateTimeEvent;
  PickerBloc({@required this.dateTimeEvent});

  final StreamController streamController = StreamController<DateTime>.broadcast();
  final pickerHeight = 200.0;
  final pickerWidth = 280.0;

  @override
  void dispose() {
    streamController.close();
  }
}
