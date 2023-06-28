part of 'event_bloc.dart';

abstract class EventEvent {}

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
