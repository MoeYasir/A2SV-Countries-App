import 'package:intl/intl.dart';

String formatPopulation(int population) {
  if (population < 1000000) {
    return NumberFormat.compact().format(population); // e.g., 530K
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
