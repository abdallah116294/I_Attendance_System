import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:i_attendance_system/lecturer_states/lecturer_set_classes.dart';
import 'package:i_attendance_system/shared/cache_helper.dart';
import 'package:path_provider/path_provider.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({super.key, this.doc});
  final doc;
  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  String className = CacheHelper.getData(key: 'class_name');
  var id = CacheHelper.getData(key: 'id');
  final List<Map<String, String>> studentList = [];
  var attendanceList = [];
  bool finish = false;
  var streem = FirebaseFirestore.instance.collection('classes').snapshots();
  var firestorintstanc = FirebaseFirestore.instance;
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

  Future<void> savaeSubCollectionDataToCSv() async {
    final subCollectionRef = FirebaseFirestore.instance
        .collection('classes')
        .doc(CacheHelper.getData(key: 'doc_id'))
        .collection('Students');
    final subCollectionData = await subCollectionRef.get();
    final List<Map<String, dynamic>> dataAsList =
        subCollectionData.docs.map((doc) => doc.data()).toList();
    final List<List<dynamic>> datatAslisOflist =
        dataAsList.map((e) => e.values.toList()).toList();

    final directort = await getApplicationDocumentsDirectory();
    final path = directort.path;
    final file = File('$path/record.csv');
    if (!await file.exists()) {
      await file.create();
    }
    final csvString = const ListToCsvConverter().convert(datatAslisOflist);
    await file.writeAsString(csvString);
  }

  Future<void> deleteColloction() async {
    final conllectionRef = FirebaseFirestore.instance
        .collection('classes')
        .doc(CacheHelper.getData(key: 'doc_id'))
        .collection('Students');
    await conllectionRef.get().then((snapshot) => {
          for (DocumentSnapshot doc in snapshot.docs) {doc.reference.delete()}
        });

    setState(() {
      finish = true;
    });
  }

  Future<void> deleteClass() async {
    final collectionRef = FirebaseFirestore.instance.collection('classes');
    final querySnapshot = await collectionRef
        .where('id', isEqualTo: CacheHelper.getData(key: 'id'))
        .get();
    final batch = FirebaseFirestore.instance.batch();
    querySnapshot.docs.forEach((element) {
      batch.delete(element.reference);
    });
    await batch.commit();
    setState(() {
      finish = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClassID(CacheHelper.getData(key: 'class_name'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteClass().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SetClass()));
                });
              }),
        ],
        title: Text(
          '$className',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('classes')
            .doc(CacheHelper.getData(key: 'doc_id'))
            .collection('Students')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('error:${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          List<DocumentSnapshot> document = snapshot.data!.docs;
          return ListView.separated(
              itemBuilder: (context, index) {
                Map<String, dynamic>? data =
                    document[index].data() as Map<String, dynamic>?;
                return Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data!['student']),
                    ));
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: document.length);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          try {
            savaeSubCollectionDataToCSv().then((value) {
              deleteColloction();
            });
          } catch (e) {
            print('no deleted');
          }
          // Collec)tionReference collectionReference =
          //     await FirebaseFirestore.instance.collection('classes');
          // collectionReference.get();
          // // CollectionReference collectionReference=
          // // CollectionReference collectionReference =
          // //    await FirebaseFirestore.instance.collection('classes');
          // // collectionReference.get().then((value) {
          // //   value.docs.forEach((element) {
          // //     element.data();
          // //   });
          // // }).then((value) {
          // //   Navigator.pushReplacement(
          // //       context, MaterialPageRoute(builder: (context)=>const SetClass()));
          // // });
          //  FirebaseFirestore.instance.runTransaction((transaction) async {
          //   await transaction.delete(collectionReference.doc().collection('Studenta').doc());
          // });
        },
        label: const Text('Finish record'),
        icon: Icon(Icons.close),
      ),
    );
  }
}
