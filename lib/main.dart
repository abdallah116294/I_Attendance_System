import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_attendance_system/shared/cache_helper.dart';
import 'package:i_attendance_system/shared_states/home.dart';
import 'package:i_attendance_system/shared_states/onboarding.dart';
import 'package:i_attendance_system/tools/file_manager.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  //creat instance from the file manager class
  final fileManager = FileManager();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  WidgetsFlutterBinding.ensureInitialized();
  //firebase instance
  await Firebase.initializeApp();
  await CacheHelper.init();
//read string from the divce
  String s = await fileManager.readFromDevice('user_type.txt');
//logic for make the
  if (s == 'error') {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((value) {
      runApp(const MyApp());
    });
  } else {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((value) {
      runApp(const Home());
    });
  }
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: OnboardingScreen());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
