import 'dart:async';
import 'package:date_time_package/picker/models/picker_modular/event/event_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../../../date_time_package.dart';
import '../picker_modular/picker_modular_bloc.dart';
import '../picker_column_delegates.dart';

const _EXTENT = 42.0;
const _PERSPECTIVE = 0.01;
const _MAGNIFICATION = 1.1;
const _OPACITY = 0.5;
const _USE_MAGNIFICATION = true;
const _SQUEEZE = 0.75;
const _DELAY = Duration(milliseconds: 250);

//MARK: PickerColumnWidget
class PickerColumnWidget extends StatelessWidget {
  static Widget seperatorWidget(String seperator) {
    return ListWheelScrollView(
      children: <Widget>[Text(seperator, style: PickerDelegate.style)],
      itemExtent: _EXTENT,
    );
  }

  PickerColumnWidget({@required this.delegate, @required this.offAxisFraction});

  final PickerDelegate delegate;
  final double offAxisFraction;
  final FixedExtentScrollController controller = FixedExtentScrollController();

  Widget build(BuildContext context) {
    return _PickerColumnWidget(
      delegate: delegate,
      offAxisFraction: offAxisFraction,
      controller: controller,
    );
  }

  void setStartingRow() {
    final index = delegate.startIndex();
    Future.delayed(Duration(microseconds: 9000), () {
      controller.jumpToItem(index);
    });
  }
}

//MARK: _PickerColumnWidget
class _PickerColumnWidget extends StatefulWidget {
  final PickerDelegate delegate;
  final double offAxisFraction;

  final FixedExtentScrollController controller;

  _PickerColumnWidget({@required this.delegate, @required this.offAxisFraction, @required this.controller});

  __PickerColumnWidget createState() => __PickerColumnWidget();
}

//MARK: __PickerColumnWidget
class __PickerColumnWidget extends State<_PickerColumnWidget> {
  Timer _timer;
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      childDelegate: widget.delegate,
      controller: widget.controller,
      itemExtent: _EXTENT,
      magnification: _MAGNIFICATION,
      useMagnifier: _USE_MAGNIFICATION,
      squeeze: _SQUEEZE,
      offAxisFraction: widget.offAxisFraction,
      onSelectedItemChanged: (index) {
        if (!widget.delegate.eventChanged(index)) return;
        _timer?.cancel();
        _timer = Timer(_DELAY, () {
          debugPrint('🥶{picker_column_widget} delegate: ${widget.delegate.toString()}');
          if (widget.delegate is YearDelegate) {
            _updateEventAndRebuildDayWidget(widget.delegate.event.setNew(year: index + 1700));
          } else if (widget.delegate is MonthDelegate) {
            _updateEventAndRebuildDayWidget(widget.delegate.event.setNew(month: (index % 12) + 1));
          } else if (widget.delegate is DayDelegate) {
            final bound = widget.delegate.event.days;
            int newDay = (index % bound) + 1;
            _updateEventAndRebuildDayWidget(widget.delegate.event.setNew(day: newDay));
          } else if (widget.delegate is HourDelegate) {
            final meridian = widget.delegate.event.meridianEnum;
            int hour = (index % 12) + ((meridian == Meridian.AM) ? 0 : 12);
            _updateEventAndRebuildDayWidget(widget.delegate.event.setNew(hour: hour));
          } else if (widget.delegate is MinuteDelegate) {
            _updateEventAndRebuildDayWidget(widget.delegate.event.setNew(minute: index % 60));
          } else if (widget.delegate is SecondDelegate) {
            _updateEventAndRebuildDayWidget(widget.delegate.event.setNew(second: index % 60));
          } else if (widget.delegate is MeridianDelegate) {
            if (index == 0) {
              int hour = widget.delegate.event.dateTime.hour - 12;
              _updateEventAndRebuildDayWidget(widget.delegate.event.setNew(hour: hour));
            } else {
              int hour = widget.delegate.event.dateTime.hour + 12;
              _updateEventAndRebuildDayWidget(widget.delegate.event.setNew(hour: hour));
            }
          }
        });
      },
      overAndUnderCenterOpacity: _OPACITY,
      physics: FixedExtentScrollPhysics(),
      perspective: _PERSPECTIVE,
    );
  }

  void _updateEventAndRebuildDayWidget(bool dayWidgetNeedsRebuild) {
    final pickerBloc = Modular.get<PickerModularBloc>();
    if (dayWidgetNeedsRebuild) {
      pickerBloc.streamController.add(widget.delegate.event.dateTime);
    }
    pickerBloc.eventBloc.add(UpdateEvent(widget.delegate.event));
  }
}
