import 'package:flutter/material.dart';
import 'package:numb/engines/calculators.dart';
import 'package:function_tree/function_tree.dart';
import 'package:numb/engines/converters.dart';

dynamic numbEngine(String text) {
  try {
    if (text.contains(RegExp(r'in ')) || text.contains(RegExp(r'to '))) {
      return converter(text);
    }
    try {
      return text.interpret();
    } catch (e) {
      return basicCalculator(text);
    }
  } catch (e) {
    return '--';
  }
}
