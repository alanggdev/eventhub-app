import 'package:eventhub_app/features/event/domain/entities/event.dart';

abstract class EventRepository {
  Future<String> createEvent(Event eventData);
  Future<List<Event>> getUserEvents(int userid);
  Future<String> deleteEvent(int eventid);
}