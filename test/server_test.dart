import 'dart:io';

import 'package:http/http.dart';
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

    final response = await post(
      Uri.parse('$host/import'),
      headers: {HttpHeaders.contentTypeHeader: 'text/xml+markr'},
      body: file,
    );
    expect(response.statusCode, 200);
    expect(response.body, 'Successfully added or updated 7 tests\n');
  });

  test('Aggregate does nothing', () async {
    final response = await get(Uri.parse('$host/results/1234/aggregate'));
    expect(response.statusCode, 200);
    expect(response.body, 'Doing nothing too\n');
  });

  test('404 on unexpected endpoint', () async {
    final response = await get(Uri.parse('$host/foobar'));
    expect(response.statusCode, 404);
  });
}
