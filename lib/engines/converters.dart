import 'package:numb/engines/conversion%20engine/conversion.dart';
import 'package:numb/engines/conversion%20engine/parser.dart';

String converter(String text) {
  Map parsedText = parser(text);
  String convertedText = conversion(parsedText);
  return convertedText;
}
