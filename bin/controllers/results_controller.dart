import 'package:shelf/shelf.dart';

class ResultsController {
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

    return Response.ok('Dummy result\n');
  }
}
