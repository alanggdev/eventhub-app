part of 'provider_bloc.dart';

abstract class ProviderEvent {}

class GetCategoryProviders extends ProviderEvent {
  final String category;

  GetCategoryProviders({required this.category});
}