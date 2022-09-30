import 'package:intl/intl.dart';
import 'package:numb/engines/text%20engine/compiler.dart';
import 'package:numb/engines/text%20engine/filtration.dart';
import 'package:function_tree/function_tree.dart';

String basicCalculator(String text, {int precision = 6}) {
  Map<String, List> filteredText = filterText(text);
  String compiledText = compileText(filteredText);

  String precisionedValue = compiledText.interpret().toStringAsFixed(precision);
  num parsed = num.parse(precisionedValue);

  String format = '###,###';

  for (int i = 0; i <= precision; i++) {
    format = i == 0 ? format + '.' : format + '#';
  }

  String formatted = NumberFormat(format).format(parsed);

  return formatted;
}
