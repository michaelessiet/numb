import 'package:numb/engines/text%20engine/filtration.dart';
import 'package:test/test.dart';

void main() {
  test('text filtration test 1', () {
    expect(
        filterText('1 divided-by 6'),
        equals({
          'operands': ['/'],
          'values': ['1', '6']
        }));
  });
  test('text filtration test 2', () {
    expect(
        filterText('1 divided-by 6 plus 8 minus 5'),
        equals({
          'operands': ['/', '+', '-'],
          'values': ['1', '6', '8', '5']
        }));
  });
  test('text filtration test 3', () {
    expect(
        filterText('66 plus 1 multiplied-by 28398743 minus 1'),
        equals({
          'operands': ['+', '*', '-'],
          'values': ['66', '1', '28398743', '1']
        }));
  });
  test('text filtration test 4', () {
    expect(
        filterText('1 / 6 + 8 * 8 ** 4'),
        equals({
          'operands': ['/', '+', '*', '^'],
          'values': ['1', '6', '8', '8', '4']
        }));
  });
  test('text filtration test 5', () {
    expect(
        filterText('1 / 6 + 8 * 8 raise-to-power 4'),
        equals({
          'operands': ['/', '+', '*', '^'],
          'values': ['1', '6', '8', '8', '4']
        }));
  });
}
