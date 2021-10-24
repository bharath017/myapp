import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:myapp/models/Child.dart';
import 'package:myapp/models/current_lesson.dart';
import 'package:myapp/models/current_topic_lessons.dart';
import 'package:myapp/services/ChildrenService.dart';

class ChildHome1 extends StatelessWidget {
  ChildrenService service = new ChildrenService();

  ChildHome() {
    //Child data = service.getChildData(1002);
  }
  final ChildrenService api = ChildrenService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LessonList(),
    );
  }
}

class LessonList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LessonList> {
  void initState() {
    getCurrentLesson(7145);
  }

  int _index = 0;
  CurrentLesson lesson = new CurrentLesson();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Text(
              'Welcome CHILD ONE',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            )),
        SizedBox(
          height: 500, // card height
          child: PageView.builder(
            itemCount: data.length,
            controller: PageController(viewportFraction: 0.7),
            onPageChanged: (int index) => setState(() => _index = index),
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: 1,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListView(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  flex: 4, // 50%
                                  child: Center(
                                    child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Text('LessonTitle')),
                                  )),
                              Expanded(
                                  flex: 6,
                                  child: Container(
                                      margin: const EdgeInsets.all(10.0),
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black38,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),

                                      // 50%

                                      child: Center(
                                        child: Text(
                                          data[i]['LessonTitle'],
                                        ),
                                      ))),
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  flex: 4, // 50%
                                  child: Center(
                                    child: Text("Status :"),
                                  )),
                              Expanded(
                                  flex: 6,
                                  child: Container(
                                      margin: const EdgeInsets.all(10.0),
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black38,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          data[i]['Status'],
                                        ),
                                      ))),
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  flex: 4, // 50%
                                  child: Center(
                                    child: Text("Marks :"),
                                  )),
                              Expanded(
                                  flex: 6,
                                  child: Container(
                                      margin: const EdgeInsets.all(10.0),
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black38,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),

                                      // 50%

                                      child: Center(
                                        child: Text(
                                          data[i]['NoOfQuestions'].toString() +
                                              '/' +
                                              data[i]['CorrectAnswers']
                                                  .toString(),
                                        ),
                                      ))),
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  flex: 4, // 50%
                                  child: Center(
                                    child: Text("Award :"),
                                  )),
                              Expanded(
                                  flex: 6,
                                  child: Container(
                                      margin: const EdgeInsets.all(10.0),
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black38,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),

                                      // 50%

                                      child: Center(
                                        child: Text(
                                          data[i]['Award'] == null
                                              ? 'No Award'
                                              : data[i]['Award'],
                                        ),
                                      ))),
                            ],
                          )),
                      Container(
                          constraints:
                              BoxConstraints(minWidth: 100, maxWidth: 200),
                          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 5, // 50%
                                child: Card(
                                  color: Color(0xff39A2DB),
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {},
                                    child: const SizedBox(
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          child: Center(
                                              child: Text(
                                            'Missed Questions',
                                          ))),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5, // 50%
                                child: Card(
                                  color: Color(0xff39A2DB),
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {},
                                    child: const SizedBox(
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          child: Center(
                                              child: Text(
                                            'Mastery Questions',
                                          ))),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List data = [];
  final String apiUrl1 = "https://localhost:5001/Lesson/Child/";
  getCurrentLesson(int ChildId) async {
    CurrentLesson lesson = new CurrentLesson();
    String url = apiUrl1 + ChildId.toString();
    final res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      var resbody = jsonDecode(res.body);
      setState(() {
        data = resbody['CurrentTopicLessons'];
      });

      print(data);
    } else {
      throw "Failed to get Lessons";
    }
  }
}

/*
Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                            child: Card(
                                child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                leading: Text(
                                  "Current Lesson :  ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                                title: Text("This is the lesson title"),
                              ),
                            ))),
*/
