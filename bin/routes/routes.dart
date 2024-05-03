import 'package:markr/test_result.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:xml/xml.dart';

class Routes {
  Handler get handler {
    var router = Router()
      ..post('/import', _importHandler)
      ..get('/results/<testId>/aggregate', _aggregateResultsHandler);
    return router.call;
  }

  Future<Response> _importHandler(Request req) async {
    // Only continue if we receive the expected Content-Type
    final expectedContentType =
        req.headers['content-type']?.contains('text/xml+markr') ?? false;
    if (!expectedContentType) {
      return Response.badRequest(
          body:
              'Expected Content-Type: text/xml+markr\nReceived ${req.headers['content-type']}');
    }

    final message = await req.readAsString();
    final List<TestResult> testResults;

    try {
      testResults = XmlDocument.parse(message)
          .findAllElements('mcq-test-result')
          .map((xmlElement) => TestResult.fromXmlElement(xmlElement))
          .toList();
    } on XmlParserException catch (e) {
      // Note: Message body could be improved to show error location, etc.
      return Response.badRequest(
          body: 'Badly formatted or missing XML, ${e.message}');
    } on ArgumentError catch (e) {
      return Response.badRequest(body: 'Field ${e.name} ${e.message}');
    }

    return Response.ok('Doing nothing\n');
  }

  Response _aggregateResultsHandler(Request req, String testId) {
    // TODO: Reject when testId isn't a number
    // TODO: Reject when testId isn't found in db

    return Response.ok('Doing nothing too\n');
  }
}
