part of 'provider_bloc.dart';

abstract class ProviderState {}

class InitialState extends ProviderState {}

class UpdatingProviderServices extends ProviderState {}
class ProviderServicesUpdated extends ProviderState {
  final String status;

  ProviderServicesUpdated({required this.status});
}

class UpdatingProviderData extends ProviderState {}
class ProviderDataUpdated extends ProviderState {
  final String status;

  ProviderDataUpdated({required this.status});
}

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