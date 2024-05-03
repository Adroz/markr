import 'dart:io';

import 'package:http/http.dart';
import 'package:markr/aggregate_result.dart';
import 'package:test/test.dart';

void main() {
  final port = '7070';
  final host = 'http://localhost:$port';
  late Process p;

  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': port},
    );
    // Wait for server to start and print to stdout.
    await p.stdout.first;
  });

  tearDown(() => p.kill());

  test('Import rejects unexpected Content-Type', () async {
    final response = await post(Uri.parse('$host/import'));
    expect(response.statusCode, 400);
    expect(response.body, contains('Expected Content-Type: text/xml+markr\n'));
  });

  test('Import rejects missing XML', () async {
    final response = await post(
      Uri.parse('$host/import'),
      headers: {HttpHeaders.contentTypeHeader: 'text/xml+markr'},
    );
    expect(response.statusCode, 400);
    expect(response.body, contains('Badly formatted or missing XML'));
  });

  test('Import rejects missing required fields', () async {
    var file = await File('./test/import_missing_fields.xml').readAsString();

    final response = await post(
      Uri.parse('$host/import'),
      headers: {HttpHeaders.contentTypeHeader: 'text/xml+markr'},
      body: file,
    );
    expect(response.statusCode, 400);
    expect(response.body,
        'Field student-number doesn\'t exist, or multiple were found.');
  });

  test('Import returns 200 with correct XML and header', () async {
    var file = await File('./test/good_import.xml').readAsString();

    // NOTE: This test has 8 entries, but one is a duplicate test-id &
    // student-number, so we only expect 7 in return.

    final response = await post(
      Uri.parse('$host/import'),
      headers: {HttpHeaders.contentTypeHeader: 'text/xml+markr'},
      body: file,
    );
    expect(response.statusCode, 200);
    expect(response.body, 'Successfully added or updated 7 tests\n');
  });

  test('Results/testId:/aggregate returns expected JSON', () async {
    var file = await File('./test/good_import.xml').readAsString();

    await post(
      Uri.parse('$host/import'),
      headers: {HttpHeaders.contentTypeHeader: 'text/xml+markr'},
      body: file,
    );

    final responseJson = AggregateResult(
            testId: 9863,
            mean: 56.42857142857143,
            count: 7,
            p25: 40,
            p50: 60,
            p75: 65)
        .toJson();

    var response = await get(Uri.parse('$host/results/9863/aggregate'));

    expect(response.body, '$responseJson\n');
  });

  test('Aggregate 404\'s corresponding testId aggregate can\'t be found',
      () async {
    int testId = 1234;
    final response = await get(Uri.parse('$host/results/$testId/aggregate'));
    expect(response.statusCode, 404);
    expect(response.body,
        'No results for the given test ($testId) could be found.\n');
  });

  test('404 on unexpected endpoint', () async {
    final response = await get(Uri.parse('$host/foobar'));
    expect(response.statusCode, 404);
  });
}
