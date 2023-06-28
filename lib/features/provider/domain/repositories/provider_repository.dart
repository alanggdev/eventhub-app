import 'package:eventhub_app/features/provider/domain/entities/provider.dart';

abstract class ProviderRepository {
  Future<List<Provider>> getCategoryProviders(String category);
}