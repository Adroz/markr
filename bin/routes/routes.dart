import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../controllers/import_controller.dart';
import '../controllers/results_controller.dart';

class Routes {
  Handler get handler {
    final importController = ImportController();
    final resultsController = ResultsController();
    var router = Router()
      ..post('/import', importController.importHandler)
      ..get(
        '/results/<testId>/aggregate',
        resultsController.aggregateResultsHandler,
      );
    return router.call;
  }
}
