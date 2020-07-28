import 'package:date_time_package/picker/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../picker_modular/picker_modular_bloc.dart';
import '../picker_modular/picker_module.dart';
import '../picker_column_delegates.dart';
import 'picker_column_widget.dart';

class TimePickerWidget extends ModularStatelessWidget<PickerModule> {
  final pickerBloc = Modular.get<PickerModularBloc>();

  Widget build(BuildContext context) {
    final slice = _pickerWidth / 25.0;
    final colonSlice = slice * 1.80;
    final timeSlice = slice * 5.0;
    // 0.20 from each of the colonSlice
    final meridianSlice = timeSlice + ((slice * 0.20) * 2.0);
    final row = [
      Container(height: _pickerHeight, width: timeSlice, child: _hourWidget()),
      Container(height: _pickerHeight, width: colonSlice, child: PickerColumnWidget.seperatorWidget(context, ':')),
      Container(height: _pickerHeight, width: timeSlice, child: _minuteWidget()),
      Container(height: _pickerHeight, width: colonSlice, child: PickerColumnWidget.seperatorWidget(context, ':')),
      Container(height: _pickerHeight, width: timeSlice, child: _secondWidget()),
      Container(height: _pickerHeight, width: meridianSlice, child: _meridianWidget()),
    ];
    return Container(
      color: timeColor.color(context),
      width: _pickerWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(children: row),
      ),
    );
  }

  double get _pickerWidth => pickerBloc.pickerWidth;
  double get _pickerHeight => pickerBloc.pickerHeight;

  PickerColumnWidget _hourWidget() =>
      PickerColumnWidget(delegate: HourDelegate(pickerBloc.dateTimeEvent), offAxisFraction: -1.0)..setStartingRow();

  PickerColumnWidget _minuteWidget() =>
      PickerColumnWidget(delegate: MinuteDelegate(pickerBloc.dateTimeEvent), offAxisFraction: 0.0)..setStartingRow();

  PickerColumnWidget _secondWidget() =>
      PickerColumnWidget(delegate: SecondDelegate(pickerBloc.dateTimeEvent), offAxisFraction: 0.0)..setStartingRow();

  PickerColumnWidget _meridianWidget() =>
      PickerColumnWidget(delegate: MeridianDelegate(pickerBloc.dateTimeEvent), offAxisFraction: 0.5)..setStartingRow();
}
