import 'package:flutter_test/flutter_test.dart';
import 'package:numb/engines/conversion%20engine/parser.dart';

void main() {
  test('1cm to inch', () {
    expect(parser('1cm in inches'),
        equals({'from': 1, 'fromUnit': 'cm', 'toUnit': 'inches'}));
  });
  test('120.3km in inch', () {
    expect(parser('120.3km in inches'),
        equals({'from': 120.3, 'fromUnit': 'km', 'toUnit': 'inches'}));
  });
  test('1cm to inch', () {
    expect(parser('1.12kmph in fps'),
        equals({'from': 1.12, 'fromUnit': 'kmph', 'toUnit': 'fps'}));
  });
  test('1.4321cm to inch', () {
    expect(parser('1.4321cm in inches'),
        equals({'from': 1.4321, 'fromUnit': 'cm', 'toUnit': 'inches'}));
  });
}
