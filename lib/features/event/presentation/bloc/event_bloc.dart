import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/event/domain/usecases/create_event.dart';
import 'package:eventhub_app/features/event/domain/entities/event.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final CreateEventUseCase createEventUseCase;

  EventBloc({required this.createEventUseCase}) : super(InitialState()) {
    on<EventEvent>(
      (event, emit) async {
        if (event is CreateEvent) {
          try {
            emit(CreatingEvent());
            Event eventData = Event(
                name: event.name,
                description: event.description,
                date: event.date,
                categories: event.categories,
                filesToUpload: event.images,
                userID: event.userID);
            String eventCreationStatus = await createEventUseCase.execute(eventData);
            emit(EventCreated(eventCreationStatus: eventCreationStatus));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        }
      },
    );
  }
}
