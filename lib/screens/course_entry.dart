import 'package:code/screens/final_gpa.dart';
import 'package:flutter/material.dart';
import 'package:code/controllers/course_controller.dart';
import 'package:code/models/course_model.dart';
import 'package:get/get.dart';

class CourseEntry extends StatefulWidget {
  const CourseEntry({super.key});

  @override
  State<CourseEntry> createState() => _CourseEntryState();
}

class _CourseEntryState extends State<CourseEntry> {
  final CourseController courseController = Get.put(CourseController());

  // List to track entry form state
  final List<CourseEntryRow> _courseRows = [];

  // List of grade values
  final List<String> _grades = [
    '-',
    'A+',
    'A',
    'A-',
    'B+',
    'B',
    'B-',
    'C+',
    'C',
    'C-',
    'D+',
    'D',
    'D-',
    'F',
    'NP'
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with a few empty rows
    for (int i = 0; i < 6; i++) {
      _courseRows.add(CourseEntryRow(
        nameController: TextEditingController(),
        creditController: TextEditingController(),
        selectedGrade: '-',
      ));
    }
  }

  // Header Row
  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            'Course (Optional)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 20),
        SizedBox(
          width: 75,
          child: Text(
            'Credits',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 20),
        SizedBox(
          width: 75,
          child: Text(
            'Grade',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildCourseEntryRow(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 160,
          child: TextField(
            controller: _courseRows[index].nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 75,
          child: TextField(
            controller: _courseRows[index].creditController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 75,
          child: DropdownButtonFormField<String>(
            value: _courseRows[index].selectedGrade,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            items: _grades.map((grade) {
              return DropdownMenuItem<String>(
                value: grade,
                child: Text(grade),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _courseRows[index].selectedGrade = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        _submitCourses();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(250, 50),
        backgroundColor: Colors.blue,
        textStyle: TextStyle(
          fontSize: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        foregroundColor: Colors.yellow,
      ),
      child: Text("Generate GPA"),
    );
  }

  void _submitCourses() {
    // Clear previous courses
    courseController.clearCourses();

    // Add all valid courses
    for (var row in _courseRows) {
      // Skip rows without credit values or with invalid values
      if (row.creditController.text.isEmpty || row.selectedGrade == '-') {
        continue;
      }

      try {
        double credits = double.parse(row.creditController.text);
        String name = row.nameController.text.isEmpty
            ? "Course ${courseController.courses.length + 1}"
            : row.nameController.text;

        double gradePoints = Course.getGradePoints(row.selectedGrade);

        Course course = Course(
          name: name,
          credits: credits,
          grade: row.selectedGrade,
          gradePoints: gradePoints,
        );

        courseController.addCourse(course);
      } catch (e) {
        print("Error adding course: $e");
        // Show error message if needed
      }
    }

    // Show a snackbar with the result
    if (courseController.courses.isNotEmpty) {
      Get.snackbar(
        "Success",
        "Added ${courseController.courses.length} courses",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );

      // Navigate to the FinalGPA screen
      Get.to(() => FinalGPA());
    } else {
      Get.snackbar(
        "Error",
        "Please add at least one course with credits and grade",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }
  }

  void _removeLastCourseRow() {
    if (_courseRows.length > 1) {
      setState(() {
        _courseRows.removeLast();
      });
      Get.snackbar(
        "Course Row Removed",
        "Removed one course entry row",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 1),
      );
    } else {
      Get.snackbar(
        "Cannot Remove",
        "At least one course entry row must remain",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 56.0, bottom: 8.0, left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // Align to the left
              children: [
                Text(
                  "GPA Flow",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: _buildHeaderRow(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 8.0), // Minimal top padding
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  for (int index = 0; index < _courseRows.length; index++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _buildCourseEntryRow(index),
                    ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: _buildSubmitButton(),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Add course button
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _courseRows.add(CourseEntryRow(
                  nameController: TextEditingController(),
                  creditController: TextEditingController(),
                  selectedGrade: '-',
                ));
              });
            },
            tooltip: 'Add Course',
            heroTag: 'addCourse',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16), // Spacing between buttons
          // Remove course button
          FloatingActionButton(
            onPressed: _removeLastCourseRow,
            tooltip: 'Remove Course',
            heroTag: 'removeCourse',
            backgroundColor: Colors.red,
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class CourseEntryRow {
  final TextEditingController nameController;
  final TextEditingController creditController;
  String selectedGrade;

  CourseEntryRow({
    required this.nameController,
    required this.creditController,
    required this.selectedGrade,
  });
}
