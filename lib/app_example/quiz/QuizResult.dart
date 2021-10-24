import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/Child.dart';
import 'package:myapp/models/User_Model.dart';

import 'package:myapp/models/lesson_model.dart';
import 'package:myapp/models/quiz_result.dart';
import 'package:myapp/services/LessonService.dart';
import 'package:myapp/services/Login_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ChildHome.dart';
import '../Quiz.dart';

class QuizResultScreen extends StatelessWidget {
  QuizResult result;
  final LessonService api = LessonService();
  QuizResultScreen(this.result);

  @override
  Widget build(BuildContext context) {
    LessonModel lesson;
    return new Scaffold(
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Color(0x440000),
          title: new Text("Quiz Completed"),
        ), // appBar
        body: ResultContent(result));
  }
}

class ResultContent extends StatefulWidget {
  QuizResult result;
  ResultContent(this.result);
  @override
  _ResultContentState createState() => _ResultContentState(result);
}

class _ResultContentState extends State<ResultContent> {
  late SharedPreferences logindata;
  QuizResult result;
  late int UserId;
  _ResultContentState(this.result);
  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      UserId = logindata.getInt('UserId')!;
    });
    print(UserId);
  }

  //late final QuizResult result;
  String comment = '';
  String comment2 = '';
  String comment3 = '';

  String ImageUrl = "https://localhost:5001/src/images/";
  @override
  Widget build(BuildContext context) {
    String imageurl;

    int percent = int.parse(result.scorePercentage.toString());
    if (percent <= 100 && percent >= 90) {
      comment = "Excellent";
      comment2 = "You have achieved GOLD!";
      ImageUrl =
          "https://cdn2.iconfinder.com/data/icons/award-and-reward-3/128/Golden-trophy-winner-champion-ward-512.png";
    } else if (percent < 90 && percent >= 80) {
      comment = "Good";
      comment2 = "You have achieved SILVER!";
      ImageUrl =
          "https://cdn2.iconfinder.com/data/icons/award-and-reward-3/128/Silver-trophy-metal-award-prize-512.png";
    } else if (percent < 80 && percent >= 60) {
      comment = "Can do better";
      comment2 = "You have achieved BRONZE!";
      ImageUrl =
          "https://cdn1.vectorstock.com/i/1000x1000/34/10/champion-bronze-medal-with-red-ribbon-icon-sign-vector-19063410.jpg";
    } else if (percent < 60) {
      comment = '';
      comment2 = "Try again to achieve a Trophy";
      comment3 = "You need more than 60% to achieve a trophy";
    }
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
            child: Text(
              comment,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 25),
            )),
        Image.network(
          ImageUrl.toString(),
          alignment: Alignment.center,
          height: 400,
          width: 400,
          errorBuilder: (context, url, error) => new Icon(Icons.error),
        ),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Text(
              comment2,
              style: TextStyle(color: Colors.black, fontSize: 18),
            )),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Text(
              comment3,
              style: TextStyle(color: Colors.black, fontSize: 18),
            )),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Text(
              "You Scored " +
                  result.correctAnswers.toString() +
                  "/" +
                  result.noOfQuestions.toString() +
                  '  (' +
                  result.scorePercentage.toString() +
                  '%)',
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      builder: (context) =>
                                          ChildHome(result.childId!)));
                            },
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Center(
                                    child: Text(
                                  'Home',
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
