import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/repositories/provider_repository.dart';

class GetProviderByUseridUseCase {
  final ProviderRepository providerRepository;

  GetProviderByUseridUseCase(this.providerRepository);

  Future<Provider> execute(int userid) async {
    return await providerRepository.getProviderByUserid(userid);
  }
}
