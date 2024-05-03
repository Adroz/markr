import 'package:markr/aggregate_result.dart';
import 'package:markr/test_result.dart';
import 'package:markr/utils/maths_helper.dart';
import 'package:test/test.dart';

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
  group('Test MathsHelper', () {
    test('Mean calculates correctly', () {
      expect(MathsHelper.mean(list), 16.75);
    });

    test('25th percentile calculates correctly', () {
      expect(MathsHelper.percentile(list, 25), 13);
    });

    test('Median calculates correctly', () {
      expect(MathsHelper.percentile(list, 50), 15);
    });

    test('75th percentile calculates correctly', () {
      expect(MathsHelper.percentile(list, 75), 22);
    });
  });

  test('Test aggregate result computes correctly', () {
    final testId = 1234;
    var testResults = List<TestResult>.empty(growable: true);
    for (var score in list) {
      testResults.add(TestResult(
          testId, 2222 + score.round(), list.last.round(), score.round()));
    }

    var agg = AggregateResult.fromTestResults(1234, testResults);
    var expectedAgg = AggregateResult(
        testId: 1234, mean: 67, count: 16, p25: 52, p50: 60, p75: 88);
    expect(agg.mean, expectedAgg.mean);
    expect(agg.count, expectedAgg.count);
    expect(agg.p25, expectedAgg.p25);
  });
}
