import 'package:flutter/material.dart';
import 'package:payments_session/features/cart/data/models/course_model.dart';

class CourseWidget extends StatelessWidget {
  final CourseModel course;

  const CourseWidget(this.course, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: .all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: .circular(12)),
              child: Icon(Icons.flutter_dash),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(course.title, style: TextStyle(fontSize: 18, fontWeight: .bold)),
                  SizedBox(height: 4),
                  Text(course.subtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
