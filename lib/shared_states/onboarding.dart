import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_attendance_system/student_states/student_onboarding.dart';
import '../lecturer_states/lecturer_onboarding.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar:AppBar(
        title: const Text(
          'iAttendance',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body:  SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.info_outline,
                        color: Colors.green,
                        size: 100,
                        semanticLabel:
                        'Text to announce in accessibility modes',
                      ),
                      Text('Welcome to iAttendance')
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CupertinoButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  LecturerOnboarding()),
                      );
                    },
                    color: Colors.green,
                    child: const Text('I am a lecturer', style: TextStyle(color: Colors.white))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CupertinoButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  StudentOnboarding()),
                      );
                    },
                    color: Colors.green,
                    child: const Text('I am a student', style: TextStyle(color: Colors.white))),
              ),
            ],
          ),
        ),
      ),

    ));
  }
}
