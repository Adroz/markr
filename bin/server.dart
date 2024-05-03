import 'dart:io';

import 'package:markr/objectbox.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import 'routes/routes.dart';

late ObjectBox objectBox;

Future<HttpServer> createServer(List<String> args) {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(Routes().handler);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  return serve(handler, ip, port);
}

void main(List<String> args) async {
  final server = await createServer(args);
  objectBox = await ObjectBox.create();

  print('Server listening on port ${server.port}');
}
