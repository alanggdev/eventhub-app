import 'package:eventhub_app/features/event/domain/entities/event.dart';
import 'package:eventhub_app/features/event/domain/repositories/event_repository.dart';

class GetUserEventsUseCase {
  final EventRepository eventRepository;

  GetUserEventsUseCase(this.eventRepository);

  Future<List<Event>> execute(int userid) async {
    return await eventRepository.getUserEvents(userid);
  }
}
