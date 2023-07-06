part of 'provider_bloc.dart';

abstract class ProviderEvent {}

class GetProviderServices extends ProviderEvent {
  final int providerid;

  GetProviderServices({required this.providerid});
}

class GetCategoryProviders extends ProviderEvent {
  final String category;

  GetCategoryProviders({required this.category});
}
