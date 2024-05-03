import 'package:shelf/shelf.dart';

import '../server.dart';

class ResultsController {
  final _aggregateBox = objectBox.aggregateResultBox;

  Future<Response> aggregateResultsHandler(Request req) async {
    // TODO: Reject when testId isn't a number
    // TODO: Reject when testId isn't found in db

    return Response.ok('Doing nothing too\n');
  }
}
