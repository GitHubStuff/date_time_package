import 'package:date_time_package/picker/models/picker_modular/picker_modular_bloc.dart';
import 'package:date_time_package/picker/models/picker_modular/picker_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'date_picker_widget.dart';
import 'segment_date_time_widget.dart';
import 'header_date_time_icon_widget.dart';
import 'time_picker_widget.dart';

enum PickerStyle { date, time }
enum PickerDisplay { both, date, time }

class DateTimePickerWidget extends ModularStatelessWidget<PickerModule> {
  final _pickerBloc = Modular.get<PickerModularBloc>();
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderDateTimeIconWidget(),
        SegmentDateTimeWidget(),
        StreamBuilder<PickerStyle>(
          stream: _pickerBloc.pickerTypeController.stream,
          builder: (context, style) {
            bool isDate = true;
            if (style.hasData) {
              isDate = (style.data == PickerStyle.date);
            }
            return isDate ? DatePickerWidget() : TimePickerWidget();
          },
        ),
      ],
    );
  }
}
