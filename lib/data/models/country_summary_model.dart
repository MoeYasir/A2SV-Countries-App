import 'package:equatable/equatable.dart';

class CountrySummary extends Equatable {
  final String name;
  final String flagUrl;
  final int population;
  final String cca2;
  final bool isFavourite;

  const CountrySummary({
    required this.name,
    required this.flagUrl,
    required this.population,
    required this.cca2,
    this.isFavourite = false,
  });
  CountrySummary copyWith({bool? isFavourite}) {
    return CountrySummary(
      name: name,
      flagUrl: flagUrl,
      population: population,
      cca2: cca2,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  factory CountrySummary.fromJson(Map<String, dynamic> json) {
    return CountrySummary(
      name: json['name']['common'] ?? 'N/A',
      flagUrl: json['flags']['svg'] ?? json['flags']['png'] ?? '',
      population: json['population'] ?? 0,
      cca2: json['cca2'] ?? '',
    );
  }

  @override
  List<Object?> get props => [name, flagUrl, population, cca2, isFavourite];
}
