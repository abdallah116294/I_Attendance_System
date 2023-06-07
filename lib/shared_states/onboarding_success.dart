import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home.dart';

class OnboardingSuccess extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          body: Center(
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
                          Icons.verified_user,
                          color: Colors.green,
                          size: 100,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                        Text('Success!')
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
                              builder: (context) =>  HomePage()),
                        );
                      },
                      color: Colors.green,
                      child: const Text('Next', style: TextStyle(color: Colors.white))),
                ),
              ],
            ),
          )),
    );
  }
}
