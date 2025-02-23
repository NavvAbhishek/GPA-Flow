import 'package:flutter/material.dart';

class FinalGPA extends StatefulWidget {
  const FinalGPA({super.key});

  @override
  State<FinalGPA> createState() => _FinalGPAState();
}

class _FinalGPAState extends State<FinalGPA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is the final GPA screen',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
