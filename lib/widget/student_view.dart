import 'package:flutter/cupertino.dart';

import '../model/student_model.dart';

class StudentView extends StatefulWidget {
   StudentView({super.key, this.students});
  Students? students;
  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  @override
  Widget build(BuildContext context) {
    return  Text(widget.students!.studentName.toString());
  }
}
