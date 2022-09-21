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
