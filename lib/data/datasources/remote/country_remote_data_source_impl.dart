import 'package:a2sv_project/core/constants/api_constants.dart';
import 'package:a2sv_project/data/datasources/remote/country_remote_data_source.dart';
import 'package:a2sv_project/data/models/country_details_model.dart';
import 'package:a2sv_project/data/models/country_summary_model.dart';
import 'package:dio/dio.dart';

class CountryRemoteDataSourceImpl implements CountryRemoteDataSource {
  final Dio dio;

  CountryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CountrySummary>> getAllCountries() async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.allCountries}',
        queryParameters: {'fields': 'name,flags,population,cca2'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CountrySummary.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }

  @override
  Future<List<CountrySummary>> searchCountriesByName(String name) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.searchByName}/$name',
        queryParameters: {'fields': 'name,flags,population,cca2'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CountrySummary.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search countries');
      }
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        return [];
      }
      throw Exception('Failed to search countries: $e');
    }
  }

  @override
  Future<CountryDetails> getCountryDetails(String code) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.searchByCode}/$code',
        queryParameters: {
          'fields':
              'name,flags,population,capital,region,subregion,area,timezones',
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final countryData = response.data as Map<String, dynamic>;
        return CountryDetails.fromJson(countryData);
      } else {
        throw Exception(
          'Failed to load country details. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching details for code $code: $e');
      if (e is DioException) {
        print('DioException Response: ${e.response}');
      }

      throw Exception('Failed to load country details: $e');
    }
  }
}
