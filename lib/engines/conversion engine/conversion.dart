import 'package:flutter/material.dart';
import 'package:numb/engines/conversion%20engine/conversions/units/length.dart';
import 'package:numb/engines/conversion%20engine/conversions/units/speed.dart';

Map<String, List> conversionClasses = {
  'length': lengthUnits.values
      .map((e) => e['phrases'])
      .expand((element) => element)
      .toList(),
  'speed': speedUnits.values
      .map((e) => e['phrases'])
      .expand((element) => element)
      .toList()
};

Map<String, Map> conversionObjects = {
  'speed': speedUnits,
  'length': lengthUnits,
};

String conversion(Map pair) {
  try {
    String key = conversionClasses.keys
        .where(
            (element) => conversionClasses[element]!.contains(pair['fromUnit']))
        .toList()[0]
        .toString();
    String toKey = conversionClasses.keys
        .where(
            (element) => conversionClasses[element]!.contains(pair['toUnit']))
        .toList()[0]
        .toString();

    if (key == toKey) {
      String fromUnitIDValue = conversionObjects[key]!
          .values
          .where((element) => element['phrases'].contains(pair['fromUnit']))
          .map((e) => e['unit'])
          .toList()[0]
          .toString();
      String toUnitIDValue = conversionObjects[key]!
          .values
          .where((element) => element['phrases'].contains(pair['toUnit']))
          .map((e) => e['unit'])
          .toList()[0]
          .toString();

      num converted = (pair['from'] * double.parse(fromUnitIDValue)) /
          double.parse(toUnitIDValue);
      return '${num.parse(converted.toStringAsFixed(4))} ${pair['toUnit']}';
    }

    return '--';
  } catch (e) {
    debugPrint(e.toString());
    return '--';
  }
}

// void main(List<String> args) {
//   print(conversion({'from': 1290, 'fromUnit': 'mps', 'toUnit': 'knot'}));
// }
