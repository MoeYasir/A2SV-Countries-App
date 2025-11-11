import 'package:a2sv_project/data/models/country_summary_model.dart';
import 'package:equatable/equatable.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<CountrySummary> favouriteCountries;

  const FavoritesLoaded(this.favouriteCountries);

  @override
  List<Object> get props => [favouriteCountries];
}
