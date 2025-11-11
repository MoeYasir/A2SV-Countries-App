import 'package:equatable/equatable.dart';

class CountrySummary extends Equatable {
  final String name;
  final String flagUrl;
  final int population;
  final String cca2;

  const CountrySummary({
    required this.name,
    required this.flagUrl,
    required this.population,
    required this.cca2,
  });

  factory CountrySummary.fromJson(Map<String, dynamic> json) {
    return CountrySummary(
      name: json['name']['common'] ?? 'N/A',
      flagUrl: json['flags']['svg'] ?? json['flags']['png'] ?? '',
      population: json['population'] ?? 0,
      cca2: json['cca2'] ?? '',
    );
  }

  @override
  List<Object?> get props => [name, flagUrl, population, cca2];
}
