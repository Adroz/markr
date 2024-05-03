import 'package:objectbox/objectbox.dart';
import 'package:xml/xml.dart';

@Entity()
class TestResult {
  @Id()
  int id = 0;

  int testId;
  int studentNumber;
  int marksAvailable;
  int marksObtained;

  TestResult(
    this.testId,
    this.studentNumber,
    this.marksAvailable,
    this.marksObtained,
  );

  factory TestResult.fromXmlElement(XmlElement xmlElement) {
    var testId = xmlElement.findElements('test-id').singleOrNull;
    var studentNumber = xmlElement.findElements('student-number').singleOrNull;
    var summaryMarks = xmlElement.findElements('summary-marks').singleOrNull;
    var marksAvailable = summaryMarks?.getAttribute('available');
    var marksObtained = summaryMarks?.getAttribute('obtained');

    // Throw errors if we're missing any of the fields we need.
    if (testId == null) {
      throw ArgumentError.value(testId, 'test-id', 'doesn\'t exist');
    }
    if (studentNumber == null) {
      throw ArgumentError.value(studentNumber, 'student-number',
          'doesn\'t exist, or multiple were found.');
    }
    if (summaryMarks == null) {
      throw ArgumentError.value(studentNumber, 'summary-marks',
          'doesn\'t exist, or multiple were found.');
    }
    if (marksAvailable == null) {
      throw ArgumentError.value(studentNumber, 'available', 'doesn\'t exist');
    }
    if (marksObtained == null) {
      throw ArgumentError.value(studentNumber, 'obtained', 'doesn\'t exist');
    }

    return TestResult(
      int.parse(testId.innerText),
      int.parse(studentNumber.innerText),
      int.parse(marksAvailable),
      int.parse(marksObtained),
    );
  }
}
