import 'package:markr/test_result.dart';
import 'package:markr/utils/maths_helper.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class AggregateResult {
  @Id()
  int id = 0;

  int testId;
  double mean;
  int count;
  double p25;
  double p50;
  double p75;

  AggregateResult({
    required this.testId,
    required this.mean,
    required this.count,
    required this.p25,
    required this.p50,
    required this.p75,
  });

  /// Given a list of test results, generate the aggregate scores.
  factory AggregateResult.fromTestResults(
      int testId, List<TestResult> testResults) {
    // Double check we're only aggregating the one testId.
    testResults.where((result) => result.testId == testId);

    var percentageScores = testResults
        .map((e) => (e.marksObtained / e.marksAvailable) * 100.0)
        .toList();

    return AggregateResult(
      testId: testId,
      mean: MathsHelper.mean(percentageScores),
      count: testResults.length,
      p25: MathsHelper.percentile(percentageScores, 25),
      p50: MathsHelper.percentile(percentageScores, 50),
      p75: MathsHelper.percentile(percentageScores, 75),
    );
  }

  Map<String, dynamic> toJson() => {
        'testId': testId,
        'mean': mean,
        'count': count,
        'p25': p25,
        'p50': p50,
        'p75': p75,
      };
}
