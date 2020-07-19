import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../date_time_package.dart';

class PickerModularBloc extends Disposable {
  DateTimeEvent dateTimeEvent;
  PickerModularBloc({@required this.dateTimeEvent});

  final StreamController dayWidgetRebuildStreamController = StreamController<DateTime>.broadcast();
  final StreamController eventUpdatedStreamController = StreamController<DateTimeEvent>.broadcast();
  final StreamController pickerTypeController = StreamController<PickerStyle>.broadcast();

  final pickerHeight = 220.0;
  final pickerWidth = 280.0;

  @override
  void dispose() {
    dayWidgetRebuildStreamController.close();
    eventUpdatedStreamController.close();
    pickerTypeController.close();
  }
}
