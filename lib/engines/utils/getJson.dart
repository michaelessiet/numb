import 'dart:convert';

import 'package:flutter/services.dart';

Future<List> getJson(String path) async {
  var filePath = await rootBundle.loadString('assets/json/timezone.json');
  List jsonData = jsonDecode(filePath);

  return jsonData;
}
