import 'package:eventhub_app/features/event/data/datasources/event_remote.dart';
import 'package:eventhub_app/features/event/domain/entities/event.dart';
import 'package:eventhub_app/features/event/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventDataSource eventDataSource;

  EventRepositoryImpl({required this.eventDataSource});

  @override
  Future<String> createEvent(Event eventData) async {
    return await eventDataSource.createEvent(eventData);
  }

  @override
  Future<List<Event>> getUserEvents(int userid) async {
    return await eventDataSource.getUserEvents(userid);
  }

  @override
  Future<String> deleteEvent(int eventid) async {
    return await eventDataSource.deleteEvent(eventid);
  }

  @override
  Future<List<Event>> getProviderEvents(int userid) async {
    return await eventDataSource.getProviderEvents(userid);
  }

  @override
  Future<String> removeProvider(int eventid) async {
    return await eventDataSource.removeProvider(eventid);
  }
}