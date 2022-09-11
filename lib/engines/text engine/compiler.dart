String compileText(Map<String, List> filteredText) {
  List operandsList = filteredText['operands']!;
  List numbers = filteredText['values']!;

  List orderedList = [];
  int currIndex = 0;
  for (String number in numbers) {
    orderedList.add(numbers[currIndex]);
    if (operandsList.lastIndexOf(operandsList.last) >= currIndex) {
      orderedList.add(operandsList[currIndex]);
    } else {}
    currIndex++;
  }

  String compiledString =
      orderedList.reduce((value, element) => value + element);

  return compiledString;
}
