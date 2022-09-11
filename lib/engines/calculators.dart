import 'package:numb/engines/text%20engine/compiler.dart';
import 'package:numb/engines/text%20engine/filtration.dart';
import 'package:function_tree/function_tree.dart';

num basicCalculator(String text) {
  Map<String, List> filteredText = filterText(text);
  String compiledText = compileText(filteredText);
  return compiledText.interpret();
}