import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:date_time_package/date_time_package.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial());

  @override
  Stream<EventState> mapEventToState(
    EventEvent event,
  ) async* {
    if (event is UpdateEvent) {
      debugPrint('🤑updated event: ${event.dateTimeEvent.formatted}');
    }
  }
}
