import 'package:flutter/material.dart';

import '../../date_time_package.dart';

const _BASEYEAR = 1700;
const _MAXYEAR = 2199;
const _FONTSIZE = 32.0;
const _MONTHSINYEAR = 12;
const _HOURSINDAY = 24;
const _MINUTESINHOUR = 60;
const _SECONDSINMINUTE = 60;

abstract class PickerDelegate extends ListWheelChildDelegate {
  static var style = TextStyle(fontSize: _FONTSIZE);
  DateTimeEvent event;
  int startIndex();
  bool eventChanged(int index);
}

//MARK:
class YearDelegate extends PickerDelegate {
  YearDelegate(DateTimeEvent event) {
    this.event = event;
  }

  Widget build(BuildContext context, int index) {
    if (index + _BASEYEAR < _BASEYEAR || index + _BASEYEAR > _MAXYEAR) return null;
    return Text('${index + _BASEYEAR}', style: PickerDelegate.style);
  }

  bool shouldRebuild(oldDelegate) => true;

  int get estimatedChildCount => (_MAXYEAR - _BASEYEAR);

  int startIndex() => event.year - _BASEYEAR;

  bool eventChanged(int index) => (index + _BASEYEAR) != event.year;
}

//MARK:
class MonthDelegate extends PickerDelegate {
  MonthDelegate(DateTimeEvent event) {
    this.event = event;
  }
  Widget build(BuildContext context, int index) {
    if (index < 0) return null;
    final normalizeToMonthNameIndex = (index % _MONTHSINYEAR) + 1;
    final monthName = DateTimeEvent.monthName(normalizeToMonthNameIndex);
    return Text('$monthName', style: PickerDelegate.style);
  }

  bool shouldRebuild(oldDelegate) => true;

  int get estimatedChildCount => 500;

  @override
  int startIndex() => ((_MONTHSINYEAR * 10) - 1) + event.dateTime.month;

  @override
  bool eventChanged(int index) => (index % _MONTHSINYEAR) + 1 != event.dateTime.month;
}

//MARK:
class DayDelegate extends PickerDelegate {
  static int _padding = 3;
  DayDelegate(DateTimeEvent event) {
    this.event = event;
  }
  Widget build(BuildContext context, int index) {
    if (index < 0) return null;
    final bound = (index % event.days) + 1;
    return Text('$bound', style: PickerDelegate.style);
  }

  bool shouldRebuild(oldDelegate) => true;

  int get estimatedChildCount => 1000;

  @override
  int startIndex() {
    final result = (event.days * _padding) + (event.dateTime.day - 1);
    if (++_padding == 10) _padding = 3;
    return result;
  }

  @override
  bool eventChanged(int index) => (index % event.days) + 1 != event.dateTime.day;

  @override
  String toString() => "{DayDelegate: {event:${event.formatted}, days:${event.days}}";
}

//MARK:
class HourDelegate extends PickerDelegate {
  HourDelegate(DateTimeEvent event) {
    this.event = event;
  }
  Widget build(BuildContext context, int index) {
    if (index < 0) return null;
    final bound = index % _HOURSINDAY;
    final tempEvent = DateTimeEvent()..setNew(hour: bound);
    return Text(tempEvent.hours, style: PickerDelegate.style);
  }

  bool shouldRebuild(oldDelegate) => true;

  int get estimatedChildCount => 1000;

  @override
  int startIndex() => (_HOURSINDAY * 5) + event.dateTime.hour;

  @override
  bool eventChanged(int index) => (index % _HOURSINDAY) != event.dateTime.hour;
}

//MARK:
class MinuteDelegate extends PickerDelegate {
  MinuteDelegate(DateTimeEvent event) {
    this.event = event;
  }
  Widget build(BuildContext context, int index) {
    if (index < 0) return null;
    final bound = index % _MINUTESINHOUR;
    final tempEvent = DateTimeEvent()..setNew(minute: bound);
    return Text(tempEvent.minutes, style: PickerDelegate.style);
  }

  bool shouldRebuild(oldDelegate) => true;

  int get estimatedChildCount => 1000;

  @override
  int startIndex() => (_MINUTESINHOUR * 2) + event.dateTime.minute;

  @override
  bool eventChanged(int index) => (index % _MINUTESINHOUR) != event.dateTime.minute;
}

//MARK:
class SecondDelegate extends PickerDelegate {
  SecondDelegate(DateTimeEvent event) {
    this.event = event;
  }
  Widget build(BuildContext context, int index) {
    if (index < 0) return null;
    final bound = index % _SECONDSINMINUTE;
    final tempEvent = DateTimeEvent()..setNew(second: bound);
    return Text(tempEvent.seconds, style: PickerDelegate.style);
  }

  bool shouldRebuild(oldDelegate) => true;

  int get estimatedChildCount => 1000;

  @override
  int startIndex() => (_SECONDSINMINUTE * 2) + event.dateTime.second;

  @override
  bool eventChanged(int index) => (index % _SECONDSINMINUTE) != event.dateTime.second;
}

//MARK:
class MeridianDelegate extends PickerDelegate {
  MeridianDelegate(DateTimeEvent event) {
    this.event = event;
  }
  Widget build(BuildContext context, int index) {
    if (index < 0 || index > 1) return null;
    final tempEvent = DateTimeEvent()..setNew(hour: (index == 0) ? 0 : 13);
    return Text(tempEvent.meridian, style: PickerDelegate.style);
  }

  bool shouldRebuild(oldDelegate) => true;

  int get estimatedChildCount => 2;

  @override
  int startIndex() => event.dateTime.hour < 12 ? 0 : 1;

  @override
  bool eventChanged(int index) =>
      (index == 0 && event.meridianEnum != Meridian.AM) || (index == 1 && event.meridianEnum != Meridian.PM);
}
