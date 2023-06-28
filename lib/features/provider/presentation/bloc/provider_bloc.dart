import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/usecases/get_category_providers.dart';

part 'provider_event.dart';
part 'provider_state.dart';

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  final GetCategoryProviersUseCase getCategoryProviersUseCase;

  ProviderBloc(
    {required this.getCategoryProviersUseCase})
    : super(InitialState()) {
      on<ProviderEvent>(
        (event, emit) async {
          if (event is GetCategoryProviders) {
            try {
              emit(GettingCategoryProviders());
              List<Provider> categoryProviders = await getCategoryProviersUseCase.execute(event.category);
              emit(CategoryProvidersLoaded(categoryProviders: categoryProviders));
            } catch (error) {
            emit(Error(error: error.toString()));
          }
          }
        }
      );
    }
}