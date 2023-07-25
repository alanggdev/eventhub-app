part of 'event_bloc.dart';

abstract class EventState {}

class InitialState extends EventState {}

class RemovingProvider extends EventState {}
class ProviderRemoved extends EventState {
  final String status;

  ProviderRemoved({required this.status});
}

class LoadingProviderEvents extends EventState {}
class ProviderEventsLoaded extends EventState {
  final List<Event> providerEvents;

  ProviderEventsLoaded({required this.providerEvents});
}

class DeletingUserEvent extends EventState {}
class UserEventDeleted extends EventState {
  final String eventDeletionStatus;

  UserEventDeleted({required this.eventDeletionStatus});
}

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