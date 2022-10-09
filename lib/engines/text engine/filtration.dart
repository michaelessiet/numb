import 'package:function_tree/function_tree.dart';
import 'package:numb/engines/utils/calc%20functions.dart';
import 'package:numb/engines/utils/operand%20phrases.dart';

List operandPhrases = [];
List operandKeys = operands.keys.toList();
List calculationFunctionKeys = functions.keys.toList();

Map<String, List> filterText(String text) {
  text = convertFunctions(text);

  for (var key in operandKeys) {
    operandPhrases.addAll(operands[key]!.take(10000));
  }

  String checkedForMathExp = text.trim().split(' ').map((e) {
    try {
      return e.interpret();
    } catch (err) {
      return e;
    }
  }).join(' ');

  List splitText = checkedForMathExp.trim().split(RegExp(r'[^0-9.]| '));
  List splitUsingDigits = checkedForMathExp.split(RegExp(r'[0-9.]| '));

  List detectedOperands = splitUsingDigits.map((e) {
    if (operandPhrases.contains(e)) {
      return e;
    }
  }).toList();

  List ops = [];
  for (var val in detectedOperands) {
    for (var key in operands.keys.toList()) {
      if (operands[key]!.contains(val)) {
        ops.add(key);
      }
    }
  }

  bool isOperandLast = splitUsingDigits.last == detectedOperands.last;
  List detectedValues = splitText
      .where((element) => RegExp(r'[0-9.]').hasMatch(element))
      .toList();

  if (isOperandLast) {
    ops.remove(ops.last);
    return {'operands': ops, 'values': detectedValues};
  }
  return {'operands': ops, 'values': detectedValues};
}

String convertFunctions(String text) {
  num result = 0;
  String finaltext = text;

  for (var value in text.split(RegExp(r' |\((?=[A-z])'))) {
    for (int i = 0; i < calculationFunctionKeys.length; i++) {
      if (value.contains(calculationFunctionKeys[i])) {
        var regex = new RegExp(r'(\d+\.\d+)|(\d+)');
        List<Match> args = regex.allMatches(value).toList();

        if (args.length > 1) {
          result = functions[calculationFunctionKeys[i]](
              num.parse(args[0][0]!), num.parse(args[1][0]!));
        } else {
          result =
              functions[calculationFunctionKeys[i]](num.parse(args[0][0]!));
        }

        finaltext = finaltext.replaceAll(value, result.toString());
      }
    }
  }

  return finaltext;
}