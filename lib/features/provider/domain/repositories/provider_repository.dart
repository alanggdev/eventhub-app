import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/entities/service.dart';

abstract class ProviderRepository {
  Future<List<Provider>> getCategoryProviders(String category);
  Future<List<Service>> getProviderServices(int providerid);
}