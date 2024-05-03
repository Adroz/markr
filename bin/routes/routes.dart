import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../controllers/test_result_controller.dart';

class Routes {
  Handler get handler {
    final examResultController = TestResultController();
    var router = Router()
      ..post('/import', examResultController.importHandler)
      ..get('/results/<testId>/aggregate', _aggregateResultsHandler);
    return router.call;
  }

  Response _aggregateResultsHandler(Request req, String testId) {
    // TODO: Reject when testId isn't a number
    // TODO: Reject when testId isn't found in db

    return Response.ok('Doing nothing too\n');
  }
}
