import 'package:a2sv_project/data/models/country_details_model.dart';
import 'package:a2sv_project/data/models/country_summary_model.dart';

abstract class CountryRemoteDataSource {
  Future<List<CountrySummary>> getAllCountries();
  Future<List<CountrySummary>> searchCountriesByName(String name);
  Future<CountryDetails> getCountryDetails(String code);
}
