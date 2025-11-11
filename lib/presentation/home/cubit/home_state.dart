import 'package:a2sv_project/data/models/country_summary_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CountrySummary> allCountries;
  final List<CountrySummary> filteredCountries;
  const HomeLoaded({
    required this.allCountries,
    required this.filteredCountries,
  });

  @override
  List<Object> get props => [allCountries, filteredCountries];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
