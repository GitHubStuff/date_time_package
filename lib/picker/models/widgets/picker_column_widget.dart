// Widget that shows the ListWheel. Date and Time are columns of these types of widgets
// that display as ListWheels. The information displayed is controlled by which type
// delegate is passed to an instance of this widget.
import 'dart:async';
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
  static Widget seperatorWidget(BuildContext context, String seperator) {
    return GestureDetector(
      onTap: null,
      child: ListWheelScrollView(
        children: <Widget>[Text(seperator, style: PickerDelegate.style(context))],
        itemExtent: _EXTENT,
      ),
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

  // The initial index is calculated by the delgate with after a small delay (insures that
  // widget has been rendered, advances to starting row).
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
    return GestureDetector(
      onTap: () {
        //absorb tap so picker is not dismissed
      },
      child: ListWheelScrollView.useDelegate(
        childDelegate: widget.delegate,
        controller: widget.controller,
        itemExtent: _EXTENT,
        magnification: _MAGNIFICATION,
        useMagnifier: _USE_MAGNIFICATION,
        squeeze: _SQUEEZE,
        offAxisFraction: widget.offAxisFraction,
        onSelectedItemChanged: (index) {
          if (!widget.delegate.eventChanged(index)) return;
          // To keep scrolling smooth, a timer is created/canceled as the user scrolls
          // only AFTER the use pauses scrolling for _DELAY amount is the date/time updated.
          _timer?.cancel();
          _timer = Timer(_DELAY, () {
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
      ),
    );
  }

  void _updateEventAndRebuildDayWidget(bool dayWidgetNeedsRebuild) {
    final pickerBloc = Modular.get<PickerModularBloc>();
    if (dayWidgetNeedsRebuild) {
      pickerBloc.dayWidgetRebuildStreamController.add(widget.delegate.event.dateTime);
    }
    pickerBloc.eventUpdatedStreamController.add(widget.delegate.event);
  }
}
