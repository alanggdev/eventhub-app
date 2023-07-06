import 'package:eventhub_app/features/provider/data/datasources/provider_remote.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/entities/service.dart';
import 'package:eventhub_app/features/provider/domain/repositories/provider_repository.dart';

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
}