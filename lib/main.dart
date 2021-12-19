import 'dart:io';

import "package:flutter/material.dart";
import 'package:myapp/app_example/ChildHome1.dart';
import 'package:myapp/app_example/Lesson.dart';
import 'package:myapp/app_example/Quiz.dart';
import 'package:myapp/app_example/Subscription_Page.dart';
import 'package:myapp/app_example/Welcome_Page.dart';
import 'package:myapp/app_example/dnd3.dart';
import 'package:myapp/models/User.dart';
import 'package:myapp/models/User_Model.dart';
import 'package:myapp/models/quiz_result.dart';
import 'package:myapp/models/user1.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_example/ChildHome.dart';
import 'app_example/Login_Screen.dart';
import 'app_example/dnd4.dart';
import 'app_example/dragndrop.dart';
import 'app_example/dragndrop2.dart';
import 'app_example/imstepper.dart';
import 'app_example/quiz/MatchTheFollowing.dart';
import 'app_example/quiz/QuizResult.dart';
import 'app_example/quiz/drawline.dart';
import 'app_example/quiz/gesture.dart';
import 'app_example/quiz/newLines.dart';
import 'models/Child1.dart';
import 'models/ChildModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  SharedPreferences? preferences;
  //late SharedPreferences logindata;
  late bool newuser = true;
  MyApp() {
    check_if_already_login();
  }

  void check_if_already_login() async {
    preferences = await SharedPreferences.getInstance();
    newuser = (preferences?.getBool('login') ?? true);
    print(newuser);
  }

  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = new MyHttpOverrides();
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.lightBlue.shade400),
      home: newuser == false
          // ? Lesson(40)
          ? WelcomePage(preferences?.getInt('UserId'))
          : LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
