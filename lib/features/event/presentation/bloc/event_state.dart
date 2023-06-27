part of 'event_bloc.dart';

abstract class EventState {}

class InitialState extends EventState {}

class GettingUserEvents extends EventState {}
class UserEventGotten extends EventState {
  final List<Event> userEvents;

  UserEventGotten({required this.userEvents});
}

class CreatingEvent extends EventState {}
class EventCreated extends EventState {
  final String eventCreationStatus;

  EventCreated({required this.eventCreationStatus});
}

class Error extends EventState {
  final String error;

  Error({required this.error});
}