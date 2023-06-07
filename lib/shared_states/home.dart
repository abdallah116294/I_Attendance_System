import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_attendance_system/lecturer_states/lecturer_set_classes.dart';
import 'package:i_attendance_system/shared/cache_helper.dart';
import 'package:i_attendance_system/student_states/student_viwe_class.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CacheHelper? cacheHelper;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.content_paste,
                color: Colors.grey,
                size: 100,
              ),
              const Text('Ready to take attendance')
            ]),
          )),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: CupertinoButton(
              onPressed: () async {
                String name = CacheHelper.getData(key: 'student_name');
                // int pin = CacheHelper.getData(key: 'pin');
                if (name.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ViewClasses()));
                } else  {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SetClass()));
                }
              },
              child: const Text('Start', style: TextStyle(color: Colors.white)),
            ),
          )
        ]),
      )),
    );
  }
}
