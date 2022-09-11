import 'package:flutter_test/flutter_test.dart';
import 'package:numb/engines/conversion%20engine/conversion.dart';
import 'package:numb/engines/conversion%20engine/parser.dart';

void main() {
  test('100cm to meters', () {
    expect(conversion(parser('100cm to meters')), equals('1.0 meters'));
  });
  test('100kmph in knots', () {
    expect(conversion(parser('100kmph in knots')), equals('53.9958 knots'));
  });
  test('300m/s in kilometers-per-hour', () {
    expect(conversion(parser('300m/s in kilometers-per-hour')),
        equals('1079.9991 kilometers-per-hour'));
  });
  test('300m/s in foot/s', () {
    expect(conversion(parser('300m/s in foot/s')),
        equals('984.252 foot/s'));
  });
  test('300m/s in miles/hour', () {
    expect(conversion(parser('300m/s in miles/hour')),
        equals('671.0809 miles/hour'));
  });
}
