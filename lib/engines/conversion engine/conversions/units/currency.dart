import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:numb/services/db/db.dart';

ExchangeRates exchangeRatesFromJson(String str) =>
    ExchangeRates.fromJson(json.decode(str));

String exchangeRatesToJson(ExchangeRates data) => json.encode(data.toJson());

class ExchangeRates {
  ExchangeRates({
    required this.base,
    required this.date,
    required this.rates,
    required this.success,
    required this.timestamp,
  });

  String base;
  DateTime date;
  Map<String, double> rates;
  bool success;
  int timestamp;

  factory ExchangeRates.fromJson(Map<String, dynamic> json) => ExchangeRates(
        base: json["base"],
        date: DateTime.parse(json["date"]),
        rates: Map.from(json["rates"])
            .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        success: json["success"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "base": base,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "success": success,
        "timestamp": timestamp,
      };
}

final Map<String, Map> currencyUnits = {
  'usd': {
    'id': 'usd',
    'phrases': ['usd', 'dollars', 'dollar'],
    'unit': 1
  }
};

Future<void> getExchangeRate() async {
  int today = DateTime.now().day;
  int thisMonth = DateTime.now().month;

  List<Map<String, dynamic>> dbData = await db.getExchangeRateData();
  int dbDataTimestampDay = 0;
  int dbDataTimestampMonth = 0;

  if (dbData.isNotEmpty) {
    dbDataTimestampDay =
        DateTime.fromMillisecondsSinceEpoch(dbData[0]['timestamp'] * 1000).day;
    dbDataTimestampMonth =
        DateTime.fromMillisecondsSinceEpoch(dbData[0]['timestamp'] * 1000)
            .month;
  }

  if (dbData.isEmpty ||
      today > dbDataTimestampDay ||
      thisMonth > dbDataTimestampMonth) {
    http.Response response = await http.get(
        Uri.parse(
            'https://api.apilayer.com/exchangerates_data/latest?base=USD'),
        headers: {'apikey': dotenv.get('EXCHANGE_RATE_KEY')});
    ExchangeRates exchangeRates = exchangeRatesFromJson(response.body);

    for (var rate in exchangeRates.rates.entries) {
      currencyUnits.addAll({
        rate.key.toLowerCase(): {
          'id': rate.key.toLowerCase(),
          'phrases': [rate.key.toLowerCase()],
          'unit': 1 / rate.value
        }
      });

      db.addCurrency(rate.key, rate.value, exchangeRates.timestamp);
    }
    debugPrint('added from api');
  } else {
    for (int i = 0; i < dbData.length; i++) {
      String key = dbData[i]['currency'];
      double rate = dbData[i]['rate'];
      currencyUnits.addAll({
        key.toLowerCase(): {
          'id': key.toLowerCase(),
          'phrases': [key.toLowerCase()],
          'unit': 1 / rate
        }
      });
    }
    debugPrint('added from db');
  }
}
