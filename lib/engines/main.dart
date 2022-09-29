import 'package:flutter/material.dart';
import 'package:numb/engines/calculators.dart';
import 'package:function_tree/function_tree.dart';
import 'package:numb/engines/converters.dart';

dynamic numbEngine(String text, {int? precision = 6}) {
  try {
    if (text.contains(RegExp(r' in ')) || text.contains(RegExp(r' to '))) {
      return converter(text);
    }
    try {
      return text.interpret().toStringAsFixed(precision!).interpret();
    } catch (e) {
      return basicCalculator(text, precision: precision);
    }
  } catch (e) {
    return '--';
  }
}
