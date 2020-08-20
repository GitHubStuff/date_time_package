// Widget that displays the date/time and icon at 'the top' of the widget
import 'package:date_time_package/picker/models/picker_modular/picker_modular_bloc.dart';
import 'package:date_time_package/picker/models/picker_modular/picker_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../date_time_package.dart';
import '../../constants.dart';

class HeaderDateTimeIconWidget extends ModularStatelessWidget<PickerModule> {
  final _pickerBloc = Modular.get<PickerModularBloc>();
  TextStyle _textStyle(BuildContext context) => TextStyle(
        fontSize: 22.0,
      );

  Widget build(BuildContext context) {
    return Container(
      height: headerHeight,
      color: primaryColor.color(context),
      width: pickerWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            StreamBuilder<DateTimeEvent>(
                stream: _pickerBloc.eventUpdatedStreamController.stream,
                builder: (context, snapshot) {
                  return _dateTimeWidget(context);
                }),
            Expanded(child: Container()),
            _iconWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _dateTimeWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _pickerBloc.dateTimeEvent.formattedDate,
          style: _textStyle(context),
          textScaleFactor: 1.0,
        ),
        SizedBox(height: 4.0),
        Text(
          _pickerBloc.dateTimeEvent.formattedTime,
          style: _textStyle(context),
          textScaleFactor: 1.0,
        ),
      ],
    );
  }

  Widget _iconWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 36,
          child: AspectRatio(
            aspectRatio: 1,
            child: setterImage,
          ),
        ),
        Expanded(child: SizedBox(height: 2.0)),
        Text(
          'Set',
          textScaleFactor: 1.0,
        ),
      ],
    );
  }
}
