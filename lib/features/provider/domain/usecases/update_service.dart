import 'package:eventhub_app/features/provider/domain/entities/service.dart';
import 'package:eventhub_app/features/provider/domain/repositories/provider_repository.dart';

class UpdateServiceUseCase {
  final ProviderRepository providerRepository;

  UpdateServiceUseCase(this.providerRepository);

  Future<String> execute(Service service) async {
    return await providerRepository.updateService(service);
  }
}
