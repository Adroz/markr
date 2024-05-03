/// A utility class to help with maths functions.
class MathsHelper {
  /// Finds the mean of a given list of numbers.
  static double mean(List<double> scores) {
    // Add all scores together
    final totalObtained = scores.fold(0.0, (a, b) => a + b);

    // Find the average as a percentage
    return totalObtained / scores.length;
  }

  /// Takes in a list of scores and a desired percentile. (Nearers Rank method)
  static double percentile(List<double> scores, double percentile) {
    scores.sort((a, b) => a.compareTo(b));

    int index = (percentile / 100.0 * scores.length).ceil();
    return scores[index - 1];
  }
}
