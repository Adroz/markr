import 'aggregate_result.dart';
import 'objectbox.g.dart';
import 'test_result.dart';

// Provide access to the ObjectBox Store throughout the server.
class ObjectBox {
  late final Store store;

  late final Box<TestResult> testResultBox;
  late final Box<AggregateResult> aggregateResultBox;

  ObjectBox._create(this.store) {
    testResultBox = Box<TestResult>(store);
    aggregateResultBox = Box<AggregateResult>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = openStore();
    return ObjectBox._create(store);
  }
}
