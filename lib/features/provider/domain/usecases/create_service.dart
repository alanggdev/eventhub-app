import 'package:eventhub_app/features/provider/domain/entities/service.dart';
import 'package:eventhub_app/features/provider/domain/repositories/provider_repository.dart';

class CreateServiceUseCase {
  final ProviderRepository providerRepository;

  CreateServiceUseCase(this.providerRepository);

  Future<String> execute(Service service, int providerid) async {
    return await providerRepository.createService(service, providerid);
  }
}
