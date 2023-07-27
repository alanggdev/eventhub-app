import 'package:eventhub_app/features/event/domain/repositories/event_repository.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';

class GetProvidersAsscoaitedUseCase {
  final EventRepository eventRepository;

  GetProvidersAsscoaitedUseCase(this.eventRepository);

  Future<List<Provider>> execute(int eventid) async {
    return await eventRepository.getProviderAssociated(eventid);
  }
}
