import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/repositories/provider_repository.dart';

class GetProviderByIdUseCase {
  final ProviderRepository providerRepository;

  GetProviderByIdUseCase(this.providerRepository);

  Future<Provider> execute(int providerid) async {
    return await providerRepository.getProviderById(providerid);
  }
}
