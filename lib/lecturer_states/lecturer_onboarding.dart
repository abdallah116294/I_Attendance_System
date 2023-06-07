import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_attendance_system/shared/cache_helper.dart';
import 'package:i_attendance_system/shared_states/onboarding.dart';
import 'package:i_attendance_system/shared_states/onboarding_success.dart';
import 'package:i_attendance_system/tools/file_manager.dart';

import 'lecturer_set_classes.dart';

class LecturerOnboarding extends StatelessWidget {
  LecturerOnboarding({super.key});
  final myController = TextEditingController();
  final fileManager = FileManager();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'iAttendance',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 100,
                    semanticLabel: 'Text to announce in accessibilty modes',
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: myController,
                      maxLength: 6,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Enter pin'),
                    ),
                  )
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CupertinoButton(
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (myController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text('Invalid Pin'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Clos'))
                            ],
                          );
                        });
                  } else {
                    FirebaseFirestore.instance
                        .collection('pins')
                        .doc(myController.text)
                        .get()
                        .then((DocumentSnapshot ds) async {
                      if (myController.text.isNotEmpty) {
                        CacheHelper.saveData(
                            key: 'pin', value: myController.text);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (cotext) =>SetClass()));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                  title: const Text('Invalid pin'),
                                  actions: <Widget>[
                                    // usually buttons at the bottom of the dialog
                                    TextButton(
                                      child: const Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ]);
                            });
                      }
                    });
                  }
                },
                color: Colors.green,
              ),
            )
          ],
        )),
      ),
    );
  }
}
