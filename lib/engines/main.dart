import 'package:intl/intl.dart';
import 'package:numb/engines/calculators.dart';
import 'package:function_tree/function_tree.dart';
import 'package:numb/engines/converters.dart';
import 'package:numb/engines/text%20engine/filtration.dart';

dynamic numbEngine(String text, {int precision = 6}) {
  try {
    if (text.contains(RegExp(r' in ')) || text.contains(RegExp(r' to '))) {
      return converter(text);
    }

    try {
      text = convertFunctions(text);
      String precisionedValue = text.interpret().toStringAsFixed(precision);
      num parsed = num.parse(precisionedValue);

      String format = '###,###';

      for (int i = 0; i <= precision; i++) {
        format = i == 0 ? format + '.' : format + '#';
      }

      String formatted = NumberFormat(format).format(parsed);

      return formatted;
    } catch (e) {
      return basicCalculator(text, precision: precision);
    }
  } catch (e) {
    return '--';
  }
}
