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
}
