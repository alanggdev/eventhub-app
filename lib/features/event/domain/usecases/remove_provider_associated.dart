import 'package:eventhub_app/features/event/domain/repositories/event_repository.dart';

class RemoveProviderAssociatedUseCase {
  final EventRepository eventRepository;

  RemoveProviderAssociatedUseCase(this.eventRepository);

  Future<String> execute(int eventid, int providerid) async {
    return await eventRepository.removeProviderAssociated(eventid, providerid);
  }
}
