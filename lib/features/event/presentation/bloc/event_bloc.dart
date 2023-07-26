import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/event/domain/usecases/get_provider_associated.dart';
import 'package:eventhub_app/features/event/domain/usecases/get_user_events.dart';
import 'package:eventhub_app/features/event/domain/usecases/delete_event.dart';
import 'package:eventhub_app/features/event/domain/usecases/get_provider_events.dart';
import 'package:eventhub_app/features/event/domain/usecases/remove_provider.dart';
import 'package:eventhub_app/features/event/domain/usecases/create_event.dart';
import 'package:eventhub_app/features/event/domain/entities/event.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/event/domain/usecases/remove_provider_associated.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final RemoveProviderAssociatedUseCase removeProviderAssociatedUseCase;
  final GetProvidersAsscoaitedUseCase getProvidersAsscoaitedUseCase;
  final RemoveProviderUseCase removeProviderUseCase;
  final GetProviderEventsUseCase getProviderEventsUseCase;
  final DeleteEventUseCase deleteEventUseCase;
  final CreateEventUseCase createEventUseCase;
  final GetUserEventsUseCase getUserEventsUseCase;

  EventBloc({
    required this.createEventUseCase,
    required this.getUserEventsUseCase,
    required this.deleteEventUseCase,
    required this.getProviderEventsUseCase,
    required this.removeProviderUseCase,
    required this.getProvidersAsscoaitedUseCase,
    required this.removeProviderAssociatedUseCase,
    }) : super(InitialState()) {
    on<EventEvent>(
      (event, emit) async {
        if (event is RemoveProviderAssociated) {
          try {
            emit(LoadingProvidersAssociated());
            String status = await removeProviderAssociatedUseCase.execute(event.eventid, event.providerid);
            emit(ProviderAssociatedRemoved(status: status));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is GetProvidersAssociated) {
          try {
            emit(LoadingProvidersAssociated());
            List<Provider> providersAssociated = await getProvidersAsscoaitedUseCase.execute(event.eventid);
            emit(ProvidersAssociatedLoaded(providersAssociated: providersAssociated));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is RemoveProvider) {
          try {
            emit(RemovingProvider());
            String status = await removeProviderUseCase.execute(event.eventid);
            emit(ProviderRemoved(status: status));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is GetProviderEvents) {
          try {
            emit(GettingUserEvents());
            List<Event> providerEvents = await getProviderEventsUseCase.execute(event.userid);
            emit(ProviderEventsLoaded(providerEvents: providerEvents));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is DeleteUserEvent) {
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
