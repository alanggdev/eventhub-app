import 'package:eventhub_app/features/event/data/datasources/event_remote.dart';
import 'package:eventhub_app/features/event/domain/entities/event.dart';
import 'package:eventhub_app/features/event/domain/repositories/event_repository.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';

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

  @override
  Future<List<Provider>> getProviderAssociated(int eventid) async {
    return await eventDataSource.getProviderAssociated(eventid);
  }

  @override
  Future<String> removeProviderAssociated(int eventid, int providerid) async {
    return await eventDataSource.removeProviderAssociated(eventid, providerid);
  }

  @override
  Future<List<Provider>> getSuggestions(String text) async {
    return await eventDataSource.getSuggestions(text);
  }
}