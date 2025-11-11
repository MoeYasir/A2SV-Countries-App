import 'package:a2sv_project/data/repositories/country_repository.dart';
import 'package:a2sv_project/presentation/favourites/cubit/favourites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final CountryRepository _countryRepository;

  FavoritesCubit(this._countryRepository) : super(FavoritesInitial());

  Future<void> loadFavouriteCountries() async {
    emit(FavoritesLoading());
    final allCountries = await _countryRepository.getAllCountries();
    final favouriteCountries = allCountries
        .where((country) => country.isFavourite)
        .toList();
    emit(FavoritesLoaded(favouriteCountries));
  }

  Future<void> removeFavourite(String cca2) async {
    final currentState = state;
    if (currentState is FavoritesLoaded) {
      await _countryRepository.removeFavourite(cca2);
      final updatedList = currentState.favouriteCountries
          .where((country) => country.cca2 != cca2)
          .toList();
      emit(FavoritesLoaded(updatedList));
    }
  }
}
