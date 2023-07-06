import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/entities/service.dart';
import 'package:eventhub_app/features/provider/domain/usecases/get_category_providers.dart';
import 'package:eventhub_app/features/provider/domain/usecases/get_provider_services.dart';

part 'provider_event.dart';
part 'provider_state.dart';

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  final GetProviderServicesUseCase getProviderServicesUseCase;
  final GetCategoryProvidersUseCase getCategoryProvidersUseCase;

  ProviderBloc(
      {required this.getCategoryProvidersUseCase,
      required this.getProviderServicesUseCase})
      : super(InitialState()) {
    on<ProviderEvent>((event, emit) async {
      if (event is GetProviderServices) {
        try {
          emit(LoadingProviderServices());
          List<Service> providerServices = await getProviderServicesUseCase.execute(event.providerid);
          emit(ProviderServicesLoaded(providerServices: providerServices));
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
