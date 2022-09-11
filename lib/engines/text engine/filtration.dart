import 'package:numb/constants/operand phrases.dart';

List operandPhrases = [];
List operandKeys = operands.keys.toList();

Map<String, List> filterText(String text) {
  for (var key in operandKeys) {
    operandPhrases.addAll(operands[key]!.take(10000));
  }
  List splitText = text.trim().split(' ');

  List detectedOperands = splitText.map((e) {
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

  bool isOperandLast = operandPhrases.contains(splitText.last);
  List detectedValues = splitText
      .where((element) => !detectedOperands.contains(element))
      .toList();

  if (isOperandLast) {
    ops.remove(ops.last);
    return {'operands': ops, 'values': detectedValues};
  }
  return {'operands': ops, 'values': detectedValues};
}
