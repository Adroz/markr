import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'aggregate_result.g.dart';

@Entity()
@JsonSerializable()
class AggregateResult {
  @Id()
  @JsonKey(includeToJson: false)
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

  /// Connect the generated [_$AggregateResultFromJson] function to the `fromJson`
  /// factory.
  factory AggregateResult.fromJson(Map<String, dynamic> json) =>
      _$AggregateResultFromJson(json);

  /// Connect the generated [_$AggregateResultToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AggregateResultToJson(this);
}
