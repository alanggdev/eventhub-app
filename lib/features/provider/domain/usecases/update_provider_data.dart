import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/repositories/provider_repository.dart';

class UpdateProviderDataUseCase {
  final ProviderRepository providerRepository;

  UpdateProviderDataUseCase(this.providerRepository);

  Future<String> execute(Provider providerData) async {
    return await providerRepository.updateProviderData(providerData);
  }
}
