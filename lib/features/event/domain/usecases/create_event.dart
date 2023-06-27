import 'package:eventhub_app/features/event/domain/entities/event.dart';
import 'package:eventhub_app/features/event/domain/repositories/event_repository.dart';

class CreateEventUseCase {
  final EventRepository eventRepository;

  CreateEventUseCase(this.eventRepository);

  Future<String> execute(Event eventData) async {
    return await eventRepository.createEvent(eventData);
  }
}
