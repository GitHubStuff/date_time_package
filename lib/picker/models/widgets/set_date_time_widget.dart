import 'package:date_time_package/picker/models/picker_modular/picker_modular_bloc.dart';
import 'package:date_time_package/picker/models/picker_modular/picker_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../date_time_package.dart';
import '../../constants.dart';

class SetDateTimeWidget extends ModularStatelessWidget<PickerModule> {
  final _pickerBloc = Modular.get<PickerModularBloc>();
  final TextStyle _textStyle = TextStyle(fontSize: 22.0);

  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      width: _pickerBloc.pickerWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            StreamBuilder<DateTimeEvent>(
                stream: _pickerBloc.eventUpdatedStreamController.stream,
                builder: (context, snapshot) {
                  return _dateTimeWidget(context);
                }),
            Expanded(
              child: Container(),
            ),
            Container(
              height: 48,
              child: AspectRatio(
                aspectRatio: 1,
                child: setterImage,
              ),
            ),
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
          style: _textStyle,
        ),
        SizedBox(height: 4.0),
        Text(
          _pickerBloc.dateTimeEvent.formattedTime,
          style: _textStyle,
        ),
      ],
    );
  }
}
