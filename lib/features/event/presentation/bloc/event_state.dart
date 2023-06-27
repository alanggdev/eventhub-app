part of 'event_bloc.dart';

abstract class EventState {}

class InitialState extends EventState {}

class CreatingEvent extends EventState {}
class EventCreated extends EventState {
  final String eventCreationStatus;

  EventCreated({required this.eventCreationStatus});
}

class Error extends EventState {
  final String error;

  Error({required this.error});
}