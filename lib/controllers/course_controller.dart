import 'package:code/models/course_model.dart';
import 'package:get/get.dart';

class CourseController extends GetxController {
  RxList<Course> courses = <Course>[].obs;
  RxDouble gpa = 0.0.obs;
  RxDouble totalCredits = 0.0.obs;
  RxDouble totalPoints = 0.0.obs;

  void addCourse(Course course) {
    courses.add(course);
    calculateGPA();
  }

  void removeCourse(int index) {
    courses.removeAt(index);
    calculateGPA();
  }

  void clearCourses() {
    courses.clear();
    calculateGPA();
  }

  void calculateGPA() {
    if (courses.isEmpty) {
      gpa.value = 0.0;
      totalCredits.value = 0.0;
      totalPoints.value = 0.0;
      return;
    }

    double totalCreditHours = 0;
    double totalGradePoints = 0;

    for (var course in courses) {
      if (course.grade != '-' && course.grade != 'NP') {
        totalCreditHours += course.credits;
        totalGradePoints += (course.credits * course.gradePoints);
      }
    }

    totalCredits.value = totalCreditHours;
    totalPoints.value = totalGradePoints;

    if (totalCreditHours > 0) {
      gpa.value = totalGradePoints / totalCreditHours;
    } else {
      gpa.value = 0.0;
    }
  }
}
