import 'package:flutter/material.dart';

class CourseEntry extends StatefulWidget {
  const CourseEntry({super.key});

  @override
  State<CourseEntry> createState() => _CourseEntryState();
}

class _CourseEntryState extends State<CourseEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is the course entry screen',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
