import 'package:equatable/equatable.dart';

class CountryDetails extends Equatable {
  final String name;
  final String flagUrl;
  final int population;
  final String capital;
  final String region;
  final String subregion;
  final double area;
  final List<String> timezones;

  const CountryDetails({
    required this.name,
    required this.flagUrl,
    required this.population,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.area,
    required this.timezones,
  });

  factory CountryDetails.fromJson(Map<String, dynamic> json) {
    return CountryDetails(
      name: json['name']['common'] ?? 'N/A',
      flagUrl: json['flags']['svg'] ?? json['flags']['png'] ?? '',
      population: json['population'] ?? 0,
      capital: (json['capital'] as List<dynamic>?)?.isNotEmpty == true
          ? json['capital'][0]
          : 'N/A',
      region: json['region'] ?? 'N/A',
      subregion: json['subregion'] ?? 'N/A',
      area: (json['area'] ?? 0.0).toDouble(),
      timezones:
          (json['timezones'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [
    name,
    flagUrl,
    population,
    capital,
    region,
    subregion,
    area,
    timezones,
  ];
}
