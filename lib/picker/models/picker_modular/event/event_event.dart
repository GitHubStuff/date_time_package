part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();
  List<Object> get props => [];
}

class UpdateEvent extends EventEvent {
  final DateTimeEvent dateTimeEvent;
  const UpdateEvent(this.dateTimeEvent);
}
