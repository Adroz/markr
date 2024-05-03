// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;

import 'aggregate_result.dart';
import 'test_result.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 1417487715709229111),
      name: 'AggregateResult',
      lastPropertyId: const obx_int.IdUid(7, 3468498929524043326),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 5545264077931384085),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 7358261212826466400),
            name: 'testId',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 8939589108594969619),
            name: 'mean',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 5965791939586749215),
            name: 'count',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 3484908363145696135),
            name: 'p25',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 5740772086289265293),
            name: 'p50',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 3468498929524043326),
            name: 'p75',
            type: 8,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 8272633613617560179),
      name: 'TestResult',
      lastPropertyId: const obx_int.IdUid(5, 440301646409968679),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 534512611983884497),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 6560050066891797667),
            name: 'testId',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 3091979724000151722),
            name: 'studentNumber',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 5399756793112765240),
            name: 'marksAvailable',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 440301646409968679),
            name: 'marksObtained',
            type: 6,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
obx.Store openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) {
  return obx.Store(getObjectBoxModel(),
      directory: directory,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(2, 8272633613617560179),
      lastIndexId: const obx_int.IdUid(0, 0),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    AggregateResult: obx_int.EntityDefinition<AggregateResult>(
        model: _entities[0],
        toOneRelations: (AggregateResult object) => [],
        toManyRelations: (AggregateResult object) => {},
        getId: (AggregateResult object) => object.id,
        setId: (AggregateResult object, int id) {
          object.id = id;
        },
        objectToFB: (AggregateResult object, fb.Builder fbb) {
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.testId);
          fbb.addFloat64(2, object.mean);
          fbb.addInt64(3, object.count);
          fbb.addFloat64(4, object.p25);
          fbb.addFloat64(5, object.p50);
          fbb.addFloat64(6, object.p75);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final testIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          final meanParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final countParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          final p25Param =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 12, 0);
          final p50Param =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 14, 0);
          final p75Param =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 16, 0);
          final object = AggregateResult(
              testId: testIdParam,
              mean: meanParam,
              count: countParam,
              p25: p25Param,
              p50: p50Param,
              p75: p75Param)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        }),
    TestResult: obx_int.EntityDefinition<TestResult>(
        model: _entities[1],
        toOneRelations: (TestResult object) => [],
        toManyRelations: (TestResult object) => {},
        getId: (TestResult object) => object.id,
        setId: (TestResult object, int id) {
          object.id = id;
        },
        objectToFB: (TestResult object, fb.Builder fbb) {
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.testId);
          fbb.addInt64(2, object.studentNumber);
          fbb.addInt64(3, object.marksAvailable);
          fbb.addInt64(4, object.marksObtained);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final testIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          final studentNumberParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final marksAvailableParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          final marksObtainedParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          final object = TestResult(testIdParam, studentNumberParam,
              marksAvailableParam, marksObtainedParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [AggregateResult] entity fields to define ObjectBox queries.
class AggregateResult_ {
  /// see [AggregateResult.id]
  static final id =
      obx.QueryIntegerProperty<AggregateResult>(_entities[0].properties[0]);

  /// see [AggregateResult.testId]
  static final testId =
      obx.QueryIntegerProperty<AggregateResult>(_entities[0].properties[1]);

  /// see [AggregateResult.mean]
  static final mean =
      obx.QueryDoubleProperty<AggregateResult>(_entities[0].properties[2]);

  /// see [AggregateResult.count]
  static final count =
      obx.QueryIntegerProperty<AggregateResult>(_entities[0].properties[3]);

  /// see [AggregateResult.p25]
  static final p25 =
      obx.QueryDoubleProperty<AggregateResult>(_entities[0].properties[4]);

  /// see [AggregateResult.p50]
  static final p50 =
      obx.QueryDoubleProperty<AggregateResult>(_entities[0].properties[5]);

  /// see [AggregateResult.p75]
  static final p75 =
      obx.QueryDoubleProperty<AggregateResult>(_entities[0].properties[6]);
}

/// [TestResult] entity fields to define ObjectBox queries.
class TestResult_ {
  /// see [TestResult.id]
  static final id =
      obx.QueryIntegerProperty<TestResult>(_entities[1].properties[0]);

  /// see [TestResult.testId]
  static final testId =
      obx.QueryIntegerProperty<TestResult>(_entities[1].properties[1]);

  /// see [TestResult.studentNumber]
  static final studentNumber =
      obx.QueryIntegerProperty<TestResult>(_entities[1].properties[2]);

  /// see [TestResult.marksAvailable]
  static final marksAvailable =
      obx.QueryIntegerProperty<TestResult>(_entities[1].properties[3]);

  /// see [TestResult.marksObtained]
  static final marksObtained =
      obx.QueryIntegerProperty<TestResult>(_entities[1].properties[4]);
}
