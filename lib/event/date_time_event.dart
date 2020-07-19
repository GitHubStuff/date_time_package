import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Meridian { AM, PM }

const _dateFormat = 'EEE, MMM d, yyyy';
const _timeFormat = 'h:mm:ss a';
const _FEBRUARY = 2;

///
class DateTimeEvent {
  static bool _leapYear(int year) => (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  static int _numberOfDays({@required int year, @required int month}) {
    final List<int> lengths = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return (_leapYear(year) && month == _FEBRUARY) ? 29 : lengths[month];
  }

  static String monthName(int index, {String format = 'MMM'}) {
    return DateFormat('MMM').format(DateTime(2020, index));
  }

  DateTime _dateTime;

  DateTimeEvent([DateTime dateTime]) {
    final event = dateTime ?? DateTime.now();
    _dateTime = DateTime(event.year, event.month, event.day, event.hour, event.minute, event.second, 0, 0);
  }

  int get days => _numberOfDays(year: _dateTime.year, month: _dateTime.month);
  DateTime get dateTime => _dateTime;
  String get formatted => '$formattedDate $formattedTime';
  String get formattedTime => DateFormat('$_timeFormat').format(_dateTime);
  String get formattedDate => DateFormat('$_dateFormat').format(_dateTime);
  bool get isLeapYear => _leapYear(_dateTime.year);
  int get year => _dateTime.year;
  String get months => DateFormat('MMM').format(_dateTime);
  String get hours => DateFormat('h').format(_dateTime);
  String get meridian => DateFormat('a').format(_dateTime);
  Meridian get meridianEnum => (_dateTime.hour < 12) ? Meridian.AM : Meridian.PM;

  bool setNew({int year, int month, int day, int hour, int minute, int second}) {
    debugPrint('🥵{SETNEW} $year $month $day $hour $minute $second');
    bool rebuildDayPickerColumn = false;
    DateTime newTime = DateTime(
      year ?? _dateTime.year,
      month ?? _dateTime.month,
      day ?? _dateTime.day,
      hour ?? _dateTime.hour,
      minute ?? _dateTime.minute,
      second ?? _dateTime.second,
    );
    if (newTime.month != (month ?? _dateTime.month)) {
      final lastDay = _numberOfDays(year: newTime.year, month: (month ?? _dateTime.month));
      newTime = DateTime(
        year ?? _dateTime.year,
        month ?? _dateTime.month,
        lastDay,
        hour ?? _dateTime.hour,
        minute ?? _dateTime.minute,
        second ?? _dateTime.second,
      );
      rebuildDayPickerColumn = true;
    } else {
      final currentDayCount = _numberOfDays(year: _dateTime.year, month: _dateTime.month);
      final newDayCount = _numberOfDays(year: newTime.year, month: newTime.month);
      rebuildDayPickerColumn = currentDayCount != newDayCount;
    }
    _dateTime = newTime;
    return rebuildDayPickerColumn;
  }

  String toString() => '{event: $formatted}';
}
