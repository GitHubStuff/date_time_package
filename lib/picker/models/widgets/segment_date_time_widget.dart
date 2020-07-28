// The widget/segment to toggle between DATE/TIME headers
import 'package:date_time_package/date_time_package.dart';
import 'package:date_time_package/picker/constants.dart';
import 'package:date_time_package/picker/models/picker_modular/picker_modular_bloc.dart';
import 'package:date_time_package/picker/models/picker_modular/picker_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SegmentDateTimeWidget extends ModularStatelessWidget<PickerModule> {
  final _pickerBloc = Modular.get<PickerModularBloc>();
  TextStyle _textStyle(BuildContext context) => TextStyle(fontSize: 28.0, color: textColor.color(context));
  static const _padding = 16.0;
  static const double _spacing = 12.0;

  Widget build(BuildContext context) {
    return Container(
      width: _pickerBloc.pickerWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _dateSegment(context),
          _timeSegment(context),
        ],
      ),
    );
  }

  Widget _dateSegment(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickerBloc.pickerTypeController.add(PickerStyle.date);
      },
      child: Container(
          width: _pickerBloc.pickerWidth / 2.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: _padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                dateImage,
                SizedBox(width: _spacing),
                Text(
                  'Date',
                  style: _textStyle(context),
                ),
              ],
            ),
          ),
          color: dateColor.color(context)),
    );
  }

  Widget _timeSegment(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickerBloc.pickerTypeController.add(PickerStyle.time);
      },
      child: Container(
        width: _pickerBloc.pickerWidth / 2.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: _padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              timeImage,
              SizedBox(width: _spacing),
              Text(
                'Time',
                style: _textStyle(context),
              ),
            ],
          ),
        ),
        color: timeColor.color(context),
      ),
    );
  }
}
