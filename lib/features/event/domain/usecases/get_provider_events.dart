import 'package:eventhub_app/features/event/domain/entities/event.dart';
import 'package:eventhub_app/features/event/domain/repositories/event_repository.dart';

class GetProviderEventsUseCase {
  final EventRepository eventRepository;

  GetProviderEventsUseCase(this.eventRepository);

  Future<List<Event>> execute(int userid) async {
    return await eventRepository.getProviderEvents(userid);
  }
}
