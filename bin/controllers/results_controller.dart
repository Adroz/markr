import 'package:collection/collection.dart';
import 'package:shelf/shelf.dart';

import '../server.dart';

/// This controller handles all interactions on the '/results' endpoint.
class ResultsController {
  final _aggregateBox = objectBox.aggregateResultBox;

  Future<Response> aggregateResultsHandler(
    Request req,
    String givenTestId,
  ) async {
    // Reject when testId isn't a number
    var testId = int.tryParse(givenTestId);

    if (testId == null) {
      return Response.badRequest(
          body: 'The given test ($givenTestId) was not a number.\n');
    }

    var aggregate = await _aggregateBox
        .getAllAsync()
        .then((aggs) => aggs.singleWhereOrNull((agg) => agg.testId == testId));

    if (aggregate == null) {
      return Response.notFound(
          'No results for the given test ($givenTestId) could be found.\n');
    }

    // Finally, send the aggregate result.
    return Response.ok('${aggregate.toJson()}\n');
  }
}
