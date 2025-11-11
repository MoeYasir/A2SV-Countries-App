// ... imports
import 'package:a2sv_project/data/datasources/local/country_local_data_sources.dart';
import 'package:a2sv_project/data/datasources/remote/country_remote_data_source.dart';
import 'package:a2sv_project/data/models/country_details_model.dart';
import 'package:a2sv_project/data/models/country_summary_model.dart';
import 'package:a2sv_project/data/repositories/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryRemoteDataSource remoteDataSource;
  final CountryLocalDataSource localDataSource;

  CountryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<CountrySummary>> getAllCountries() async {
    final remoteCountries = await remoteDataSource.getAllCountries();
    final favouriteCodes = localDataSource.getFavouriteCodes();
    return remoteCountries.map((country) {
      return country.copyWith(
        isFavourite: favouriteCodes.contains(country.cca2),
      );
    }).toList();
  }

  @override
  Future<CountryDetails> getCountryDetails(String code) {
    return remoteDataSource.getCountryDetails(code);
  }

  @override
  Future<void> addFavourite(String code) {
    return localDataSource.addFavourite(code);
  }

  @override
  Future<void> removeFavourite(String code) {
    return localDataSource.removeFavourite(code);
  }

  @override
  Future<List<CountrySummary>> searchCountriesByName(String name) async {
    final remoteCountries = await remoteDataSource.searchCountriesByName(name);
    final favouriteCodes = localDataSource.getFavouriteCodes();
    return remoteCountries.map((country) {
      return country.copyWith(
        isFavourite: favouriteCodes.contains(country.cca2),
      );
    }).toList();
  }
}
