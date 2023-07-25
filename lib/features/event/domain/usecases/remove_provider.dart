import 'package:eventhub_app/features/event/domain/repositories/event_repository.dart';

class RemoveProviderUseCase {
  final EventRepository eventRepository;

  RemoveProviderUseCase(this.eventRepository);

  Future<String> execute(int eventid) async {
    return await eventRepository.removeProvider(eventid);
  }
}
