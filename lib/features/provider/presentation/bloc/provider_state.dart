part of 'provider_bloc.dart';

abstract class ProviderState {}

class InitialState extends ProviderState {}

class GettingCategoryProviders extends ProviderState {}
class CategoryProvidersLoaded extends ProviderState {
  final List<Provider> categoryProviders;

  CategoryProvidersLoaded({required this.categoryProviders});
}

class Error extends ProviderState {
  final String error;

  Error({required this.error});
}