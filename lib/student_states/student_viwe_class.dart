import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:i_attendance_system/model/student_model.dart';
import 'package:i_attendance_system/widget/classes_widget.dart';

class ViewClasses extends StatefulWidget {
  const ViewClasses({super.key});

  @override
  State<ViewClasses> createState() => _ViewClassesState();
}

class _ViewClassesState extends State<ViewClasses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'iAttendance',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('classes').snapshots(),
          builder: (context, AsyncSnapshot dataSnapshot) {
            if (dataSnapshot.hasData) {
              return ListView.separated(
                itemCount: dataSnapshot.data!.docs.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, indexx) {
                  Classes eachstudentInfo = Classes.fromJson(
                      dataSnapshot.data!.docs[indexx].data()
                          as Map<String, dynamic>);
                  return ClassesUi(classes: eachstudentInfo,);
                },
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Center(
                      child: CircularProgressIndicator(
                    color: Colors.pinkAccent,
                  )),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
