import 'package:eventhub_app/features/provider/domain/entities/service.dart';
import 'package:eventhub_app/features/provider/domain/repositories/provider_repository.dart';

class GetProviderServicesUseCase {
  final ProviderRepository providerRepository;

  GetProviderServicesUseCase(this.providerRepository);

  Future<List<Service>> execute(int providerid) async {
    return await providerRepository.getProviderServices(providerid);
  }
}
