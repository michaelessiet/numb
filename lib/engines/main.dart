import 'package:intl/intl.dart';
import 'package:numb/engines/calculators.dart';
import 'package:function_tree/function_tree.dart';
import 'package:numb/engines/converters.dart';
import 'package:numb/engines/text%20engine/filtration.dart';
import 'package:numb/engines/time%20converter.dart';

dynamic numbEngine(String text, {int precision = 6})async {
  try {
    if (text.contains(RegExp(r'time(?!\w) | time(?= in )'))) {

      return await getTimeAtLocation(text);
    }

    if (text.contains(RegExp(r' in ')) || text.contains(RegExp(r' to '))) {
      return converter(text);
    }

    try {
      text = convertFunctions(text);

      String precisionedValue = text.interpret().toStringAsFixed(precision);
      num parsePrecisionValue = num.parse(precisionedValue);

      String format = '###,###';

      for (int i = 0; i <= precision; i++) {
        format = i == 0 ? format + '.' : format + '#';
      }

      String formatted = NumberFormat(format).format(parsePrecisionValue);

      return formatted;
    } catch (e) {
      return basicCalculator(text, precision: precision);
    }
  } catch (e) {
    return '--';
  }
}

// void main(List<String> args) async {
//   final now = new Stopwatch()..start();
//   var timezones = await File('./utils/timezone.json').readAsString();
//   List timezonesObj = jsonDecode(timezones.toLowerCase());
//   print(
//       timezonesObj.where((element) => element.containsValue(args[0])).toList());
//   print(
//       timezonesObj.where((element) => element.containsValue(args[1])).toList());
//   print(
//       timezonesObj.where((element) => element.containsValue(args[2])).toList());
//   print(
//       timezonesObj.where((element) => element.containsValue(args[3])).toList());
//   print('this took ${now.elapsed.inMilliseconds}');
// }