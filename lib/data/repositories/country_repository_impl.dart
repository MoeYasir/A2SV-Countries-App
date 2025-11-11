import 'package:a2sv_project/data/datasources/remote/country_remote_data_source.dart';
import 'package:a2sv_project/data/models/country_details_model.dart';
import 'package:a2sv_project/data/models/country_summary_model.dart';
import 'package:a2sv_project/data/repositories/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryRemoteDataSource remoteDataSource;

  CountryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CountrySummary>> getAllCountries() {
    return remoteDataSource.getAllCountries();
  }

  @override
  Future<List<CountrySummary>> searchCountriesByName(String name) {
    return remoteDataSource.searchCountriesByName(name);
  }

  @override
  Future<CountryDetails> getCountryDetails(String code) {
    return remoteDataSource.getCountryDetails(code);
  }
}
