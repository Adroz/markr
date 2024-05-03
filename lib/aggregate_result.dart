import 'package:objectbox/objectbox.dart';

@Entity()
class AggregateResult {
  @Id()
  int id = 0;

  int testId;
  double mean;
  double count;
  double p25;
  double p50;
  double p75;

  AggregateResult(
    this.testId,
    this.mean,
    this.count,
    this.p25,
    this.p50,
    this.p75,
  );
}
