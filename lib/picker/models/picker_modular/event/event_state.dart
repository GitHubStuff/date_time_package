part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();
}

class EventInitial extends EventState {
  @override
  List<Object> get props => [];
}
