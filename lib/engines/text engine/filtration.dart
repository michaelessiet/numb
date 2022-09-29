import 'package:flutter/foundation.dart';
import 'package:function_tree/function_tree.dart';
import 'package:numb/engines/operand%20phrases.dart';

List operandPhrases = [];
List operandKeys = operands.keys.toList();

Map<String, List> filterText(String text) {
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

// String filterFactorials(String text) {
//   // String newString = '';
//   List<String> textArray = text.split(' ');

//   for (int i = 0; i < textArray.length; i++) {
//     if (operands['!']!.contains(textArray[i])) {
//       num number = textArray[i-1].interpret();
//       num iterator = textArray[i-1].interpret()-1;
//       while (iterator > 1) {
//         number = number * iterator;
//         iterator--;
//       }
//       textArray.replaceRange(i-1, i+1, [number.toString()]);
//     }
//   }
//   print(textArray);
//   return textArray.join();
// }
