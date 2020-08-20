// Collection of all the ListWheelChildDelegates for month,day,year,hour,minute,second,meridian
import 'package:date_time_package/picker/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../date_time_package.dart';

const _BASEYEAR = 1700;
const _MAXYEAR = 2199;
const _FONTSIZE = 34.0;
const _MONTHSINYEAR = 12;
const _HOURSINDAY = 24;
const _MINUTESINHOUR = 60;
const _SECONDSINMINUTE = 60;

abstract class PickerDelegate extends ListWheelChildDelegate {
  DateTimeEvent event; //Shared across all widgets....
  int startIndex();
  bool eventChanged(int index);
  static TextStyle style(BuildContext context) => TextStyle(fontSize: _FONTSIZE, color: textColor.color(context));
}

//MARK:
class YearDelegate extends PickerDelegate {
  YearDelegate(DateTimeEvent event) {
    this.event = event;
  }

  //Text for a year is created using the base year and adding the index, and insuring
  //it does not go past max year.
  Widget build(BuildContext context, int index) {
    if (index + _BASEYEAR < _BASEYEAR || index + _BASEYEAR > _MAXYEAR) return null;
    return Text(
      '${index + _BASEYEAR}',
      style: PickerDelegate.style(context),
      textScaleFactor: 1.0,
    );
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
    // Use the date/time format to create the string/text of the month name
    // to fudge/enable localization
    final monthName = DateTimeEvent.monthName(normalizeToMonthNameIndex);
    return Text(
      '$monthName',
      style: PickerDelegate.style(context),
      textScaleFactor: 1.0,
    );
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
    return Text(
      '$bound',
      style: PickerDelegate.style(context),
      textScaleFactor: 1.0,
    );
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
    int hour;
    if (bound == 0) {
      hour = 12;
    } else {
      hour = (bound <= 12) ? bound : bound - 12;
    }
    return Text(
      hour.toString().padLeft(2, '0'),
      style: PickerDelegate.style(context),
      textScaleFactor: 1.0,
    );
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
    return Text(
      bound.toString().padLeft(2, '0'),
      style: PickerDelegate.style(context),
      textScaleFactor: 1.0,
    );
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
    return Text(
      bound.toString().padLeft(2, '0'),
      style: PickerDelegate.style(context),
      textScaleFactor: 1.0,
    );
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
    // Use date format for meridian string to simplify localization
    final meridian = DateFormat('a').format(DateTime(2020, 1, 1, (index == 0) ? 0 : 13, 0, 0, 0, 0));
    return Text(
      meridian,
      style: PickerDelegate.style(context),
      textScaleFactor: 1.0,
    );
  }

  bool shouldRebuild(oldDelegate) => true;

  int get estimatedChildCount => 2;

  @override
  int startIndex() => event.dateTime.hour < 12 ? 0 : 1;

  @override
  bool eventChanged(int index) =>
      (index == 0 && event.meridianEnum != Meridian.AM) || (index == 1 && event.meridianEnum != Meridian.PM);
}
