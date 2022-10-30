import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numb/engines/conversion%20engine/conversions/units/angular.dart';
import 'package:numb/engines/conversion%20engine/conversions/units/area.dart';
import 'package:numb/engines/conversion%20engine/conversions/units/currency.dart';
import 'package:numb/engines/conversion%20engine/conversions/units/length.dart';
import 'package:numb/engines/conversion%20engine/conversions/units/speed.dart';
import 'package:numb/engines/conversion%20engine/conversions/units/storage.dart';
import 'package:numb/engines/conversion%20engine/conversions/units/time.dart';
import 'package:numb/engines/conversion%20engine/conversions/units/volume.dart';
import 'package:numb/engines/conversion%20engine/conversions/units/weight.dart';

Map<String, Map> conversionObjects = {
  'speed': speedUnits,
  'length': lengthUnits,
  'storage': storageUnits,
  'volume': volumeUnits,
  'currency': currencyUnits,
  'time': timeUnits,
  'area':areaUnits,
  'weight':weightUnits,
  'angles': angularUnits
};

Map<String, List> conversionClasses = conversionObjects.map((key, value) =>
    MapEntry(
        key,
        value.values
            .map((e) => e['phrases'])
            .expand((element) => element)
            .toList()));

String conversion(Map pair) {
  try {
    String fromkey = conversionClasses.keys
        .where(
            (element) => conversionClasses[element]!.contains(pair['fromUnit']))
        .toList()[0]
        .toString();
    String toKey = conversionClasses.keys
        .where(
            (element) => conversionClasses[element]!.contains(pair['toUnit']))
        .toList()[0]
        .toString();

    if (fromkey == toKey) {
      String fromUnitIDValue = conversionObjects[fromkey]!
          .values
          .where((element) => element['phrases'].contains(pair['fromUnit']))
          .map((e) => e['unit'])
          .toList()[0]
          .toString();
      String toUnitIDValue = conversionObjects[fromkey]!
          .values
          .where((element) => element['phrases'].contains(pair['toUnit']))
          .map((e) => e['unit'])
          .toList()[0]
          .toString();

      num converted = (pair['from'] * double.parse(fromUnitIDValue)) /
          double.parse(toUnitIDValue);

      String precisionedValue = converted.toStringAsFixed(4);
      num reparsed = num.parse(precisionedValue);
      String formattedValue = NumberFormat().format(reparsed);

      return '${formattedValue} ${pair['toUnit']}';
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
