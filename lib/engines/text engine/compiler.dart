String compileText(Map<String, List> filteredText) {
  List operandsList = filteredText['operands']!;
  List numbers = filteredText['values']!;

  if (operandsList.isEmpty && numbers.length == 1) {
    return numbers.single;
  }

  List orderedList = [];
  if (operandsList.length == numbers.length) {
    for (int i = 0; i < numbers.length; i++) {
      orderedList.add(operandsList[i]);
      if (numbers.lastIndexOf(numbers.last) >= 1) {
        orderedList.add(numbers[i]);
      }
    }
  } else {
    for (int i = 0; i < numbers.length; i++) {
      orderedList.add(numbers[i]);
      if (operandsList.lastIndexOf(operandsList.last) >= i) {
        orderedList.add(operandsList[i]);
      } else {}
    }
  }

  String compiledString =
      orderedList.reduce((value, element) => value + element);

  return compiledString;
}
