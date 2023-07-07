part of 'provider_bloc.dart';

abstract class ProviderState {}

class InitialState extends ProviderState {}

class LoadingProviderDetail extends ProviderState {}
class ProviderDetailLoaded extends ProviderState {
  final Provider providerData;
  final List<Service> providerServices;

  ProviderDetailLoaded({required this.providerData, required this.providerServices});
}

class LoadingCategoryProviders extends ProviderState {}
class CategoryProvidersLoaded extends ProviderState {
  final List<Provider> categoryProviders;

  CategoryProvidersLoaded({required this.categoryProviders});
}

class Error extends ProviderState {
  final String error;

  Error({required this.error});
}