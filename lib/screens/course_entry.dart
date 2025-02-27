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
  String? _selectedGrade;

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
    } else {
      Get.snackbar(
        "Error",
        "Please add at least one course with credits and grade",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeaderRow(),
              SizedBox(height: 10),
              ...List.generate(_courseRows.length, (index) {
                return Column(
                  children: [
                    _buildCourseEntryRow(index),
                    SizedBox(height: 20),
                  ],
                );
              }),
              SizedBox(height: 30), // Space before the button
              _buildSubmitButton(), // Submit Button
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
        child: Icon(Icons.add),
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
