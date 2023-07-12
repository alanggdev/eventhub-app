import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/entities/service.dart';

abstract class ProviderRepository {
  Future<List<Provider>> getCategoryProviders(String category);
  Future<List<Service>> getProviderServices(int providerid);
  Future<Provider> getProviderById(int providerid);
  Future<Provider> getProviderByUserid(int userid);
  Future<String> updateProviderData(Provider providerData);
  Future<String> createService(Service service, int providerid);
  Future<String> deleteService(int serviceid);
  Future<String> updateService(Service service);
}