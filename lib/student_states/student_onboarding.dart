import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:i_attendance_system/shared/cache_helper.dart';
import 'package:i_attendance_system/shared_states/onboarding.dart';
import 'package:i_attendance_system/student_states/student_viwe_class.dart';
import '../shared_states/onboarding_success.dart';
import '../tools/file_manager.dart';
import 'package:flutter/cupertino.dart';

class StudentOnboarding extends StatelessWidget {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: const Text(
              'iAttendance',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.person_pin,
                          color: Colors.green,
                          size: 100,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter full name'),
                            controller: myController,
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text('Name cannot be changed later'))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CupertinoButton(
                      child:
                          Text('Submit', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (myController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return CupertinoAlertDialog(
                                title: new Text("Name cannot be blank"),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  new TextButton(
                                    child: new Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return CupertinoAlertDialog(
                                title: Text("Are you sure?"),
                                content: Text('You have entered ' +
                                    myController.text +
                                    '. This cannot be changed later.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("Go back"),
                                    onPressed: () {
                                      // remove the pop up
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  // usually buttons at the bottom of the dialog
                                  TextButton(
                                    child: const Text("Confirm"),
                                    onPressed: () async {
                                      // write to device
                                      CacheHelper.saveData(
                                          key: 'student_name',
                                          value: myController.text);
                                      // remove the pop up
                                      Navigator.of(context).pop();
                                      // navigate to the new page
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                              const  ViewClasses()),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      color: Colors.green),
                ),
              ],
            ),
          )),
    );
  }
}
