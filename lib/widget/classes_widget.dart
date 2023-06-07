import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:i_attendance_system/model/student_model.dart';
import 'package:i_attendance_system/shared/cache_helper.dart';

import '../shared_states/attendance_succes.dart';

class ClassesUi extends StatefulWidget {
  ClassesUi({
    super.key,
    this.classes,
  });
  Classes? classes;

  @override
  State<ClassesUi> createState() => _ClassesUiState();
}

class _ClassesUiState extends State<ClassesUi> {
  void getClassID(String className) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("classes")
        .where('class', isEqualTo: CacheHelper.getData(key: 'class_name'))
        .get();
    if (snapshot.docs.isNotEmpty) {
      String classid = snapshot.docs.first.id;
      CacheHelper.saveData(key: 'doc_id', value: classid);
      print(classid);
    } else {
      print('no class found with name $className');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          String name = CacheHelper.getData(key: 'student_name');
          CollectionReference collectionReference =
              FirebaseFirestore.instance.collection("classes");
          QuerySnapshot querySnapshot = await collectionReference.get();
          querySnapshot.docs.forEach((documentSnapshot) async {
            CollectionReference subcollectionRef =
                documentSnapshot.reference.collection('Students');
            await subcollectionRef.add({"student": name});
          });
          // FirebaseFirestore.instance.collection('classes').doc();
          // QuerySnapshot snapshot =FirebaseFirestore.instance.collection('classes');
          // var doc = snapshot.data.document;

          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AttendanceSuccess()))
              .then((value) {
            // CacheHelper.removeData(key: 'student_name');
          });
        },
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.classes!.className.toString(),
                style: TextStyle(fontSize: 20),
              ),
            )));
  }
}
