import 'dart:math';

import 'package:collection/collection.dart';
import 'package:markr/aggregate_result.dart';
import 'package:markr/objectbox.g.dart';
import 'package:markr/test_result.dart';
import 'package:shelf/shelf.dart';
import 'package:xml/xml.dart';

import '../server.dart';

/// This controller handles all interactions on the '/import' endpoint.
class ImportController {
  final _testBox = objectBox.testResultBox;
  final _aggregateBox = objectBox.aggregateResultBox;

  Future<Response> importHandler(Request req) async {
    // Only continue if we receive the expected Content-Type
    final expectedContentType =
        req.headers['content-type']?.contains('text/xml+markr') ?? false;
    if (!expectedContentType) {
      return Response.badRequest(
          body:
              'Expected Content-Type: text/xml+markr\nReceived ${req.headers['content-type']}');
    }

    final message = await req.readAsString();
    final List<TestResult> testsFromImport;

    try {
      testsFromImport = XmlDocument.parse(message)
          .findAllElements('mcq-test-result')
          .map((xmlElement) => TestResult.fromXmlElement(xmlElement))
          .toList();
    } on XmlParserException catch (e) {
      // Note: Message body could be improved to show error location, etc.
      return Response.badRequest(
          body: 'Badly formatted or missing XML, ${e.message}');
    } on ArgumentError catch (e) {
      return Response.badRequest(body: 'Field ${e.name} ${e.message}');
    }

    // Calculate and save tests and aggregates to the database.
    var results = _getNewOrUpdatedResults(testsFromImport);
    await _testBox.putManyAsync(results);

    // Get the testId's of what was added/updated, then find all the records in
    // the db (since we might have some existing ones).
    var newOrUpdatedTestIds = results.map((e) => e.testId).toList();
    var affectedTestsQuery =
        _testBox.query(TestResult_.testId.oneOf(newOrUpdatedTestIds)).build();
    var affectedTests = await affectedTestsQuery.findAsync();
    affectedTestsQuery.close();

    var aggregates = _getNewOrUpdatedAggregates(affectedTests);
    await _aggregateBox.putManyAsync(aggregates);

    return Response.ok(
        'Successfully added or updated ${results.length} tests\n');
  }

  // TODO: Add tests
  List<TestResult> _getNewOrUpdatedResults(List<TestResult> testResults) {
    final repeatTestResultsQuery = _testBox
        .query(
          TestResult_.studentNumber.equals(0) & TestResult_.testId.equals(0),
        )
        .build();

    // We add all results we want to add (or existing results to update) to a
    // list so we can do a single write.
    var resultsToAddOrUpdate = List<TestResult>.empty(growable: true);

    for (var test in testResults) {
      repeatTestResultsQuery.param(TestResult_.studentNumber).value =
          test.studentNumber;
      repeatTestResultsQuery.param(TestResult_.testId).value = test.testId;

      // Return an existing user from the current list, or the db.
      // Throw if there's more than one result, or leave null.
      final existingInDb = repeatTestResultsQuery.findUnique();
      final existingInToAdd = resultsToAddOrUpdate.singleWhereOrNull((e) =>
          e.studentNumber == test.studentNumber && e.testId == test.testId);
      final existingResult = existingInDb ?? existingInToAdd;

      if (existingResult == null) {
        // We don't have this test & student, so add it to the list to save.
        resultsToAddOrUpdate.add(test);
      } else {
        // TODO: Do a comparison on existing vs new result so we don't unnecessarily update the existing result with the same values.

        // We have this test & student already, so use the highest available and
        // obtained test scores.
        existingResult.marksAvailable =
            max(existingResult.marksAvailable, test.marksAvailable);
        existingResult.marksObtained =
            max(existingResult.marksObtained, test.marksObtained);

        if (existingInToAdd == null) {
          // We don't need to add an item that's already in the list to add, but
          // adding an existing db result won't duplicate it, it'll just update
          // its property values.
          resultsToAddOrUpdate.add(existingResult);
        }
      }
    }
    repeatTestResultsQuery.close();

    return resultsToAddOrUpdate;
  }

  // TODO: Add tests
  List<AggregateResult> _getNewOrUpdatedAggregates(
      List<TestResult> testResults) {
    final repeatAggQuery =
        _aggregateBox.query(AggregateResult_.testId.equals(0)).build();

    // We add all results we want to add (or existing results to update) to a
    // list so we can do a single write.
    var aggToAddOrUpdate = List<AggregateResult>.empty(growable: true);

    // Group the results so we can iterate on testId.
    testResults
        .groupListsBy((result) => result.testId)
        .forEach((testId, results) {
      repeatAggQuery.param(AggregateResult_.testId).value = testId;

      // return the only result or null if none, throw if more than one result
      final existingAgg = repeatAggQuery.findUnique();
      var newAgg = AggregateResult.fromTestResults(testId, results);

      if (existingAgg == null) {
        // We don't have this test aggregate yet, so add it to the list to save.
        aggToAddOrUpdate.add(newAgg);
      } else {
        // We have this test aggregate already, so update the calculation.
        newAgg.id = existingAgg.id;

        // Adding an existing result won't duplicate it, it'll just update its
        // property values.
        aggToAddOrUpdate.add(newAgg);
      }
    });

    repeatAggQuery.close();

    return aggToAddOrUpdate;
  }
}
