import 'package:eventhub_app/features/event/domain/repositories/event_repository.dart';

class DeleteEventUseCase {
  final EventRepository eventRepository;

  DeleteEventUseCase(this.eventRepository);

  Future<String> execute(int eventid) async {
    return await eventRepository.deleteEvent(eventid);
  }
}
