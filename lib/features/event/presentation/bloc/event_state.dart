part of 'event_bloc.dart';

abstract class EventState {}

class InitialState extends EventState {}

class LoadingSuggestions extends EventState {}
class SuggestionsLoaded extends EventState {
  final List<Provider> providersSuggest;

  SuggestionsLoaded({required this.providersSuggest});
}

class LoadingProvidersAssociated extends EventState {}
class ProvidersAssociatedLoaded extends EventState {
  final List<Provider> providersAssociated;

  ProvidersAssociatedLoaded({required this.providersAssociated});
}

class ProviderAssociatedRemoved extends EventState {
  final String status;

  ProviderAssociatedRemoved({required this.status});
}

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