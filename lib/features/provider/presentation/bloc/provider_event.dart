part of 'provider_bloc.dart';

abstract class ProviderEvent {}

class GetProviderDetailByUserId extends ProviderEvent {
  final int providerUserId;

  GetProviderDetailByUserId({required this.providerUserId});
}

class GetProviderDetailById extends ProviderEvent {
  final int providerid;

  GetProviderDetailById({required this.providerid});
}

class GetCategoryProviders extends ProviderEvent {
  final String category;

  GetCategoryProviders({required this.category});
}
