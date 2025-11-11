import 'package:intl/intl.dart';

String formatPopulation(int population) {
  if (population < 1000000) {
    return NumberFormat.compact().format(population);
  } else {
    final formatter = NumberFormat.compact(explicitSign: false);
    formatter.maximumFractionDigits = 1;
    formatter.minimumFractionDigits = 1;

    String formatted = formatter.format(population);
    if (!formatted.contains('.')) {
      formatted = formatted.replaceAllMapped(RegExp(r'(\d+)([A-Z])'), (match) {
        return '${match.group(1)}.0${match.group(2)}';
      });
    }
    return formatted;
  }
}

String formatPopulationWithWords(int population) {
  if (population >= 1000000000) {
    double num = population / 1000000000;
    return '${NumberFormat('0.##').format(num)} billion';
  } else if (population >= 1000000) {
    double num = population / 1000000;
    return '${NumberFormat('0.##').format(num)} million';
  } else {
    return NumberFormat('#,##0').format(population);
  }
}

String formatArea(double area) {
  final numberFormat = NumberFormat('#,##0');
  return '${numberFormat.format(area)} sq km';
}
