import 'package:test/test.dart';

import '../bin/utils/math_helper.dart';

void main() {
  final list = [
    9.0,
    10.0,
    12.0,
    13.0,
    13.0,
    13.0,
    15.0,
    15.0,
    16.0,
    16.0,
    18.0,
    22.0,
    23.0,
    24.0,
    24.0,
    25.0,
  ];

  // Test answers generated here:
  // https://www.calculatorsoup.com/calculators/statistics/mean-median-mode.php
  // https://www.free-online-calculator-use.com/percentile-calculator.html

  test('Mean calculates correctly', () {
    expect(MathHelper.mean(list), 16.75);
  });

  test('25th percentile calculates correctly', () {
    expect(MathHelper.percentile(list, 25), 13);
  });

  test('Median calculates correctly', () {
    expect(MathHelper.percentile(list, 50), 15);
  });

  test('75th percentile calculates correctly', () {
    expect(MathHelper.percentile(list, 75), 22);
  });
}
