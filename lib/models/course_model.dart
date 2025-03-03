class Course {
  String name;
  double credits;
  String grade;
  double gradePoints;

  Course({
    required this.name,
    required this.credits,
    required this.grade,
    required this.gradePoints,
  });

  // Convert grade to numeric value for GPA calculation
  static double getGradePoints(String grade) {
    switch (grade) {
      case 'A+':
        return 4.3;
      case 'A':
        return 4.0;
      case 'A-':
        return 3.7;
      case 'B+':
        return 3.3;
      case 'B':
        return 3.0;
      case 'B-':
        return 2.7;
      case 'C+':
        return 2.3;
      case 'C':
        return 2.0;
      case 'C-':
        return 1.7;
      case 'D+':
        return 1.3;
      case 'D':
        return 1.0;
      case 'D-':
        return 0.7;
      case 'F':
        return 0.0;
      case 'NP':
        return 0.0;
      default:
        return 0.0;
    }
  }
}
