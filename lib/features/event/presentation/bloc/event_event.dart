part of 'event_bloc.dart';

abstract class EventEvent {}

class GetSuggestions extends EventEvent {
  final String text;

   GetSuggestions({required this.text});
}

class RemoveProviderAssociated extends EventEvent{
  final int eventid, providerid;

  RemoveProviderAssociated({required this.eventid, required this.providerid});
}

class GetProvidersAssociated extends EventEvent{
  final int eventid;

  GetProvidersAssociated({required this.eventid});
}

class RemoveProvider extends EventEvent {
  final int eventid;

  RemoveProvider({required this.eventid});
}

class GetProviderEvents extends EventEvent {
  final int userid;

  GetProviderEvents({required this.userid});
}

class DeleteUserEvent extends EventEvent {
  final int eventid;

  DeleteUserEvent({required this.eventid});
}

class GetUserEvents extends EventEvent {
  final int userid;

  GetUserEvents({required this.userid});
}

class CreateEvent extends EventEvent {
  final String name, description, date;
  final List<String> categories;
  final int userID;
  final List<File> images;

  CreateEvent({
    required this.name,
    required this.description,
    required this.date,
    required this.categories,
    required this.userID,
    required this.images,
  });
}
