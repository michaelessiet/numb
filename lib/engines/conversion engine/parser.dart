Map<String, dynamic> parser(String text) {
  List<String> textList = text.split(' ');
  String leftside = textList[0];
  String rightside = textList[textList.length - 1];

  num leftnumber = num.parse(leftside.split(RegExp(r'([A-z][/]|[A-z]|-)'))[0]);
  String leftUnit =
      text.split(RegExp(r'(\d+\.\d+|\d+ |\d+)'))[1].split(' ')[0].toLowerCase();
  String rightUnit = rightside.split(RegExp(r'(\d+)'))[0].toLowerCase();

  return {
    'from': leftnumber,
    'fromUnit': leftUnit,
    'toUnit': rightUnit,
  };
}

// void main(List<String> args) {
//   print(parser('300m/s in kilometers-per-second'));
// }
