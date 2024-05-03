import 'dart:io';

import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  final port = '7070';
  final host = 'http://127.0.0.1:$port';
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

  test('Import does nothing', () async {
    final response = await post(Uri.parse('$host/import'));
    expect(response.statusCode, 200);
    expect(response.body, 'Doing nothing\n');
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
