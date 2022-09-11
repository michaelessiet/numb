import 'package:numb/engines/calculators.dart';
import 'package:numb/engines/converters.dart';

dynamic numbEngine(String text) {
  try {
    if (text.contains('in') || text.contains('to')) {
      return converter(text);
    }
    return basicCalculator(text);
  } catch (e) {
    return '--';
  }
}
