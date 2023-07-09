import 'package:eventhub_app/features/provider/domain/entities/service.dart';
import 'package:eventhub_app/features/provider/domain/repositories/provider_repository.dart';

class UpdateProviderServicesUseCase {
  final ProviderRepository providerRepository;

  UpdateProviderServicesUseCase(this.providerRepository);

  Future<String> execute(List<Service> servicesData, int providerid) async {
    return await providerRepository.updateProviderServices(servicesData, providerid);
  }
}
