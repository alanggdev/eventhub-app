import 'package:eventhub_app/features/provider/domain/repositories/provider_repository.dart';

class DeleteServiceUseCase {
  final ProviderRepository providerRepository;

  DeleteServiceUseCase(this.providerRepository);

  Future<String> execute(int serviceid) async {
    return await providerRepository.deleteService(serviceid);
  }
}
