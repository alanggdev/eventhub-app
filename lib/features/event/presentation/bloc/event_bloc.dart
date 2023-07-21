import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/event/domain/usecases/create_event.dart';
import 'package:eventhub_app/features/event/domain/entities/event.dart';
import 'package:eventhub_app/features/event/domain/usecases/get_user_events.dart';
import 'package:eventhub_app/features/event/domain/usecases/delete_event.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final DeleteEventUseCase deleteEventUseCase;
  final CreateEventUseCase createEventUseCase;
  final GetUserEventsUseCase getUserEventsUseCase;

  EventBloc(
      {required this.createEventUseCase,
      required this.getUserEventsUseCase,
      required this.deleteEventUseCase})
      : super(InitialState()) {
    on<EventEvent>(
      (event, emit) async {
        if (event is DeleteUserEvent) {
          try {
            emit(DeletingUserEvent());
            String eventDeletionStatus = await deleteEventUseCase.execute(event.eventid);
            emit(UserEventDeleted(eventDeletionStatus: eventDeletionStatus));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is GetUserEvents) {
          try {
            emit(GettingUserEvents());
            List<Event> userEvents = await getUserEventsUseCase.execute(event.userid);
            emit(UserEventGotten(userEvents: userEvents));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is CreateEvent) {
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
