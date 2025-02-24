import 'package:flutter/material.dart';

class CourseEntry extends StatefulWidget {
  const CourseEntry({super.key});

  @override
  State<CourseEntry> createState() => _CourseEntryState();
}

class _CourseEntryState extends State<CourseEntry> {
  String? _selectedGrade;

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

  Widget _buildCourseEntryRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 160,
          child: TextField(
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
            value: _selectedGrade,
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
                _selectedGrade = value;
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
        print("GPA Generated!");
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
              _buildCourseEntryRow(),
              SizedBox(height: 20),
              _buildCourseEntryRow(),
              SizedBox(height: 20),
              _buildCourseEntryRow(),
              SizedBox(height: 20),
              _buildCourseEntryRow(),
              SizedBox(height: 20),
              _buildCourseEntryRow(),
              SizedBox(height: 20),
              _buildCourseEntryRow(),
              SizedBox(height: 20),
              _buildCourseEntryRow(),
              SizedBox(height: 20),
              _buildCourseEntryRow(),
              SizedBox(height: 30), // Space before the button
              _buildSubmitButton(), // Submit Button
            ],
          ),
        ),
      ),
    );
  }
}
