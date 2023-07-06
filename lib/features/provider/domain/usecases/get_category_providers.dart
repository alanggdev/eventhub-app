import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/repositories/provider_repository.dart';

class GetCategoryProvidersUseCase {
  final ProviderRepository providerRepository;

  GetCategoryProvidersUseCase(this.providerRepository);

  Future<List<Provider>> execute(String category) async {
    return await providerRepository.getCategoryProviders(category);
  }
}
