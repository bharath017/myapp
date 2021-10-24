import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/Child.dart';
import 'package:myapp/models/User_Model.dart';

import 'package:myapp/models/lesson_model.dart';
import 'package:myapp/services/LessonService.dart';
import 'package:myapp/services/Login_service.dart';
import 'package:http/http.dart' as http;

import 'ChildHome.dart';
import 'Login_Screen.dart';
import 'Quiz.dart';

class Lesson extends StatelessWidget {
  int lessonId;
  final LessonService api = LessonService();
  Lesson(this.lessonId);
  @override
  Widget build(BuildContext context) {
    LessonModel lesson;
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Color(0x44000000),
        title: new Text("Lesson Page"),
      ), // appBar
      body: FutureBuilder<LessonModel>(
        future: api.getLesson(lessonId),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? LessonContent(lesson: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class LessonContent extends StatelessWidget {
  final LessonModel lesson;

  LessonContent({Key? key, required this.lesson}) : super(key: key);
  String image = "https://localhost:5001/src/images/";
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
            child: Text(
              lesson.lessonTitle.toString(),
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 25),
            )),
        Image.asset(
          'assets/numbersimage.jpeg',
          //image + lesson.imageUrl.toString(),
          alignment: Alignment.center,
          //errorBuilder: (context, url, error) => new Icon(Icons.error),
        ),
        Container(
            height: 300,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Text(
              lesson.content.toString(),
              style: TextStyle(color: Colors.black, fontSize: 18),
            )),
        SizedBox(
            height: 100,
            child: Card(
              elevation: 4,
              child: ListView(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.5);
                                  else if (states
                                      .contains(MaterialState.disabled))
                                    return Colors.grey.shade200;
                                  return Color(
                                      0xff39A2DB); // Use the component's default.
                                },
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChildHome(5)));
                            },
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Center(
                                    child: Text(
                                  'Home',
                                ))),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.5);
                                  else if (states
                                      .contains(MaterialState.disabled))
                                    return Colors.grey.shade200;
                                  return Color(
                                      0xff39A2DB); // Use the component's default.
                                },
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuizScreen(
                                          lessonId: lesson.lessonId)));
                            },
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Center(
                                    child: Text(
                                  'QUIZ',
                                ))),
                          ),
                        ],
                      )),
                ],
              ),
            )),
      ],
    );
  }
}
