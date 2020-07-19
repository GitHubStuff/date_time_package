import 'package:date_time_package/picker/models/picker_modular/picker_modular_bloc.dart';
import 'package:date_time_package/picker/models/picker_modular/picker_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../picker_column_delegates.dart';
import 'picker_column_widget.dart';

class DatePickerWidget extends ModularStatelessWidget<PickerModule> {
  final pickerBloc = Modular.get<PickerModularBloc>();

  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: _pickerWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(children: [
          Container(height: _pickerHeight, width: _pickerWidth * 0.24, child: _buildDayWidget()),
          Container(height: _pickerHeight, width: _pickerWidth * 0.03, child: PickerColumnWidget.seperatorWidget('-')),
          Container(height: _pickerHeight, width: _pickerWidth * 0.33, child: _monthWidget()),
          Container(height: _pickerHeight, width: _pickerWidth * 0.03, child: PickerColumnWidget.seperatorWidget('-')),
          Container(height: _pickerHeight, width: _pickerWidth * 0.33, child: _yearWidget()),
        ]),
      ),
    );
  }

  double get _pickerWidth => pickerBloc.pickerWidth;
  double get _pickerHeight => pickerBloc.pickerHeight;

  PickerColumnWidget _yearWidget() =>
      PickerColumnWidget(delegate: YearDelegate(pickerBloc.dateTimeEvent), offAxisFraction: 0.35)..setStartingRow();

  PickerColumnWidget _monthWidget() =>
      PickerColumnWidget(delegate: MonthDelegate(pickerBloc.dateTimeEvent), offAxisFraction: 0.0)..setStartingRow();

  Widget _buildDayWidget() {
    final pickerBloc = Modular.get<PickerModularBloc>();

    return StreamBuilder<DateTime>(
      stream: pickerBloc.streamController.stream,
      builder: (context, snapshot) {
        return PickerColumnWidget(delegate: DayDelegate(pickerBloc.dateTimeEvent), offAxisFraction: -0.35)
          ..setStartingRow();
      },
    );
  }
}
