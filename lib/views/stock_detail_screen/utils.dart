import 'package:intl/intl.dart';

String formatMarketCap(num value) {
  final formatter = NumberFormat('#,###');

  if (value >= 1000000000000) {
    final trillion = value ~/ 1000000000000;
    final billion = (value % 1000000000000) ~/ 100000000;

    if (billion > 0) {
      return '${formatter.format(trillion)}조 ${formatter.format(billion)}억';
    } else {
      return '${formatter.format(trillion)}조';
    }
  } else if (value >= 100000000) {
    final billion = value ~/ 100000000;
    return '${formatter.format(billion)}억';
  } else {
    return formatter.format(value);
  }
}
