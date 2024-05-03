import 'dart:math';

import 'package:markr/objectbox.g.dart';
import 'package:markr/test_result.dart';
import 'package:shelf/shelf.dart';
import 'package:xml/xml.dart';

import '../server.dart';

class TestResultController {
  final _testBox = objectBox.testResultBox;

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
    final List<TestResult> testResults;

    try {
      testResults = XmlDocument.parse(message)
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

      // return the only result or null if none, throw if more than one result
      final existingResult = repeatTestResultsQuery.findUnique();

      if (existingResult == null) {
        // We don't have this test & student, so add it to the list to save.
        resultsToAddOrUpdate.add(test);
      } else {
        // We have this test & student already, so use the highest available and
        // obtained test scores.
        existingResult.marksAvailable =
            max(existingResult.marksAvailable, test.marksAvailable);
        existingResult.marksObtained =
            max(existingResult.marksAvailable, test.marksAvailable);

        // Adding an existing result won't duplicate it, it'll just update its
        // property values.
        resultsToAddOrUpdate.add(existingResult);
      }
    }
    repeatTestResultsQuery.close();

    await _testBox.putManyAsync(resultsToAddOrUpdate);

    return Response.ok(
        'Successfully added or updated ${resultsToAddOrUpdate.length} tests\n');
  }
}
