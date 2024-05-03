// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aggregate_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AggregateResult _$AggregateResultFromJson(Map<String, dynamic> json) =>
    AggregateResult(
      testId: (json['testId'] as num).toInt(),
      mean: (json['mean'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
      p25: (json['p25'] as num).toDouble(),
      p50: (json['p50'] as num).toDouble(),
      p75: (json['p75'] as num).toDouble(),
    )..id = (json['id'] as num).toInt();

Map<String, dynamic> _$AggregateResultToJson(AggregateResult instance) =>
    <String, dynamic>{
      'testId': instance.testId,
      'mean': instance.mean,
      'count': instance.count,
      'p25': instance.p25,
      'p50': instance.p50,
      'p75': instance.p75,
    };
