import 'package:eventhub_app/features/provider/domain/usecases/get_provider_by_id.dart';
import 'package:eventhub_app/features/provider/domain/usecases/get_provider_by_userid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/entities/service.dart';
import 'package:eventhub_app/features/provider/domain/usecases/get_category_providers.dart';
import 'package:eventhub_app/features/provider/domain/usecases/get_provider_services.dart';

part 'provider_event.dart';
part 'provider_state.dart';

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  final GetProviderByUseridUseCase getProviderByUseridUseCase;
  final GetProviderByIdUseCase getProviderByIdUseCase;
  final GetProviderServicesUseCase getProviderServicesUseCase;
  final GetCategoryProvidersUseCase getCategoryProvidersUseCase;

  ProviderBloc(
      {required this.getCategoryProvidersUseCase,
      required this.getProviderServicesUseCase,
      required this.getProviderByIdUseCase,
      required this.getProviderByUseridUseCase})
      : super(InitialState()) {
    on<ProviderEvent>((event, emit) async {
      if (event is GetProviderDetailByUserId) {
        try {
          emit(LoadingProviderDetail());
          Provider providerData = await getProviderByUseridUseCase.execute(event.providerUserId);
          List<Service> providerServices = await getProviderServicesUseCase.execute(providerData.providerId!);
          emit(ProviderDetailLoaded(providerData: providerData, providerServices: providerServices));
        } catch (error) {
          emit(Error(error: error.toString()));
        }
      } else if (event is GetProviderDetailById) {
        try {
          emit(LoadingProviderDetail());
          Provider providerData = await getProviderByIdUseCase.execute(event.providerid);
          List<Service> providerServices = await getProviderServicesUseCase.execute(event.providerid);
          emit(ProviderDetailLoaded(providerData: providerData, providerServices: providerServices));
        } catch (error) {
          emit(Error(error: error.toString()));
        }
      } else if (event is GetCategoryProviders) {
        try {
          emit(LoadingCategoryProviders());
          List<Provider> categoryProviders = await getCategoryProvidersUseCase.execute(event.category);
          emit(CategoryProvidersLoaded(categoryProviders: categoryProviders));
        } catch (error) {
          emit(Error(error: error.toString()));
        }
      }
    });
  }
}
