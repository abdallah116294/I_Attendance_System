import 'dart:io';
import 'dart:math';

import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_attendance_system/shared/cache_helper.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:i_attendance_system/lecturer_states/lecturer_view_student.dart';
import 'package:i_attendance_system/tools/file_manager.dart';

class SetClass extends StatefulWidget {
  const SetClass({super.key});

  @override
  State<SetClass> createState() => _SetClassState();
}

class _SetClassState extends State<SetClass> {
  // final fileManager = FileManager();
  Random random = Random();
  // FlutterBlue flutterBlue = FlutterBlue.instance;
  // BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  final myController = TextEditingController();
  int? _id;
  String? _deviceId;
  Future<void> initPlatformState() async {
    String? devicId;
    try {
      devicId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      devicId = "Faild to get deviceId";
    }
    if (!mounted) return;
    setState(() {
      _deviceId = devicId;
      print(_deviceId);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _id = random.nextInt(65534);
    super.initState();
    // initAndroidId();
    // print(_androidId);
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.event_note,
                    color: Colors.green,
                    size: 100,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Enter class name'),
                      controller: myController,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: CupertinoButton(
              child: Text('Next', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                if (myController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewStudents()),
                  );

                  // store class name and beacon id
                  FirebaseFirestore.instance
                      .collection('classes')
                      .doc()
                      .set({'id': _id, 'class': myController.text});
                  CacheHelper.saveData(key: 'id', value: _id);
                  CacheHelper.saveData(
                      key: 'class_name', value: myController.text);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return CupertinoAlertDialog(
                        title: const Text("Please Type the class name"),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          TextButton(
                            child: const Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              color: Colors.green,
            ),
          )
        ]),
      )),
    );
  }
}
