import 'package:eventhub_app/features/event/domain/repositories/event_repository.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';

class GetSuggestionsUseCase {
  final EventRepository eventRepository;

  GetSuggestionsUseCase(this.eventRepository);

  Future<List<Provider>> execute(String text) async {
    return await eventRepository.getSuggestions(text);
  }
}
