import 'package:eventhub_app/features/provider/data/datasources/provider_remote.dart';
import 'package:eventhub_app/features/provider/domain/repositories/provider_repository.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/entities/service.dart';

class ProviderRepositoryImpl implements ProviderRepository {
  final ProviderDataSource providerDataSource;

  ProviderRepositoryImpl({required this.providerDataSource});

  @override
  Future<List<Provider>> getCategoryProviders(String category) async {
    return await providerDataSource.getCategoryProviders(category);
  }

  @override
  Future<List<Service>> getProviderServices(int providerid) async {
    return await providerDataSource.getProviderServices(providerid);
  }

  @override
  Future<Provider> getProviderById(int providerid) async {
    return await providerDataSource.getProviderById(providerid);
  }

  @override
  Future<Provider> getProviderByUserid(int userid) async {
    return await providerDataSource.getProviderByUserid(userid);
  }

  @override
  Future<String> updateProviderData(Provider providerData) async {
    return await providerDataSource.updateProviderData(providerData);
  }

  @override
  Future<String> createService(Service service, int providerid) async {
    return await providerDataSource.createService(service, providerid);
  }

  @override
  Future<String> deleteService(int serviceid) async {
    return await providerDataSource.deleteService(serviceid);
  }

  @override
  Future<String> updateService(Service service) async {
    return await providerDataSource.updateService(service);
  }
}