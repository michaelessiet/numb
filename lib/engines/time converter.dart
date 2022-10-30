import 'package:intl/intl.dart';
import 'package:numb/engines/utils/getJson.dart';
import 'package:numb/engines/utils/timezones%20search%20algo.dart';
import 'package:timezone/standalone.dart' as tz;

Future<String> getTimeAtLocation(String text) async {
  String replacedText = text.replaceAll(RegExp(r'time|in'), '').trim();
  List timezonejson = await getJson('assets/json/timezones.json');

  timezonejson.sort(((a, b) => a['city'].toString().compareTo(b['city'])));
  String timezone =
      searchForStringInMap(timezonejson, replacedText)['timezone'];
  var location = tz.getLocation(timezone);
  tz.TZDateTime timeObject = tz.TZDateTime.now(location);
  String hour = NumberFormat('00').format(timeObject.hour);
  String minute = NumberFormat('00').format(timeObject.minute);

  String time = '$hour:$minute';

  return time;
}
