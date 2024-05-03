import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Routes {
  Handler get handler {
    var router = Router()
      ..post('/import', _importHandler)
      ..get('/results/<testId>/aggregate', _aggregateResultsHandler);
    return router.call;
  }

  Response _importHandler(Request req) {
    // TODO: Reject when content-type isn't text/xml-markr
    // TODO: Reject when XML is malformed
    // TODO: Reject when and fields we expect are missing

    return Response.ok('Doing nothing\n');
  }

  Response _aggregateResultsHandler(Request req, String testId) {
    // TODO: Reject when testId isn't a number
    // TODO: Reject when testId isn't found in db

    return Response.ok('Doing nothing too\n');
  }
}
