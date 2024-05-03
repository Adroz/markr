import 'package:objectbox/objectbox.dart';

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
}
