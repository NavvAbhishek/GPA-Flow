import 'package:code/controllers/bottom_nav_controller.dart';
import 'package:code/screens/course_entry.dart';
import 'package:code/screens/final_gpa.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final BottomNavController controller = Get.put(BottomNavController());

  static const List<Widget> pages = <Widget>[CourseEntry(), FinalGPA()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GPA Flow"),
      ),
      body: Center(child: Obx(() => pages[controller.selectedIndex.value])),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.edit), label: 'Course Entry'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calculate), label: 'Final GPA'),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.deepOrange,
          onTap: (index) => controller.changeIndex(index),
        ),
      ),
    );
  }
}
