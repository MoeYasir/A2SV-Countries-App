import 'package:a2sv_project/data/repositories/country_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CountryRepository _countryRepository;

  HomeCubit(this._countryRepository) : super(HomeInitial());

  Future<void> fetchAllCountries() async {
    try {
      emit(HomeLoading());
      final countries = await _countryRepository.getAllCountries();
      emit(HomeLoaded(allCountries: countries, filteredCountries: countries));
    } catch (e) {
      emit(HomeError('Failed to fetch countries. Please try again.'));
    }
  }

  void searchCountry(String query) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      if (query.isEmpty) {
        emit(
          HomeLoaded(
            allCountries: currentState.allCountries,
            filteredCountries: currentState.allCountries,
          ),
        );
      } else {
        final filteredList = currentState.allCountries
            .where(
              (country) =>
                  country.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

        emit(
          HomeLoaded(
            allCountries: currentState.allCountries,
            filteredCountries: filteredList,
          ),
        );
      }
    }
  }

  Future<void> toggleFavouriteStatus(String cca2) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final countryToUpdate = currentState.allCountries.firstWhere(
        (c) => c.cca2 == cca2,
      );

      final isCurrentlyFavourite = countryToUpdate.isFavourite;

      if (isCurrentlyFavourite) {
        await _countryRepository.removeFavourite(cca2);
      } else {
        await _countryRepository.addFavourite(cca2);
      }

      final updatedAllCountries = currentState.allCountries.map((country) {
        if (country.cca2 == cca2) {
          return country.copyWith(isFavourite: !isCurrentlyFavourite);
        }
        return country;
      }).toList();

      final updatedFilteredCountries = currentState.filteredCountries.map((
        country,
      ) {
        if (country.cca2 == cca2) {
          return country.copyWith(isFavourite: !isCurrentlyFavourite);
        }
        return country;
      }).toList();

      emit(
        HomeLoaded(
          allCountries: updatedAllCountries,
          filteredCountries: updatedFilteredCountries,
        ),
      );
    }
  }
}
