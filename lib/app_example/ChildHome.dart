import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:myapp/ModifiedPackages/Glow/Glow.dart';
import 'package:myapp/evnironment/Api.dart';
import 'package:myapp/models/Child.dart';
import 'package:myapp/models/current_lesson.dart';
import 'package:myapp/models/current_topic_lessons.dart';
import 'package:myapp/services/ChildrenService.dart';
import 'package:myapp/stepper/first_stepper/number_stepper.dart';

import 'Lesson.dart';

class ChildHome extends StatelessWidget {
  //ChildrenService service = new ChildrenService();
  int childId;
  ChildHome(this.childId);
  //final ChildrenService api = ChildrenService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LearnToUnlock'),
        elevation: 0,
        backgroundColor: Color(0x44000000),
      ),
      body: SafeArea(child: LessonList(childId: childId)),
    );
  }
}

class LessonList extends StatefulWidget {
  int childId;

  LessonList({Key? key, required this.childId}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _State(childId);
}

class _State extends State<LessonList> {
  int ChildId;
  _State(this.ChildId) {
    getCurrentLesson(ChildId);
  }
  List<bool> status = [];
  List<int> values = [];
  void initState() {}
  bool loading = true;
  int i = 0;
  List data = [];
  bool noData = false;
  int activeStep = 0;
  int selectedborder = 0;
  ApiURL api = new ApiURL();
  // final String apiUrl1 = "https://localhost:5001/Lesson/Child/";
  getCurrentLesson(int ChildId) async {
    print("Child id");
    print(ChildId);

    CurrentLesson lesson = new CurrentLesson();
    String url = api.geturl + 'Lesson/Child/' + ChildId.toString();
    final res = await get(Uri.parse(url));
    print(res.body);
    if (res.statusCode == 200) {
      var resbody = jsonDecode(res.body);
      setState(() {
        data = resbody['CurrentTopicLessons'];
        print(data);
        loading = false;
      });
      if (data.isNotEmpty) {
        for (int j = 0; j < data.length; j++) {
          print(data[j]['LessonCompleted']);
          if (data[j]['LessonCompleted'] == true) {
            if (j < data.length - 1) {
              setState(() {
                activeStep = j + 1;
                selectedborder = j + 1;

                i = j + 1;
              });

              continue;
            } else {
              activeStep = j;
              selectedborder = j;
            }
          } else {
            setState(() {
              activeStep = j;
              selectedborder = j;
              i = j;
            });
            break;
          }
        }
      } else {
        noData = true;
        NoLessons();
      }
    } else {
      NoLessons();
      throw "Failed to get Lessons";
    }
  }

  // Initial step set to 5.

  //int upperBound = 6; // upperBound MUST BE total number of icons minus 1.

  int _index = 0;
  CurrentLesson lesson = new CurrentLesson();
  bool nextLesson = false;
  bool _animate = true;
  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;
    var scrnlength = orientation == Orientation.portrait
        ? _screenHeight - 20
        : _screenWidth - 20;
    print(_screenWidth * 0.01);
    if (loading) return Center(child: CircularProgressIndicator());
    if (noData) return NoLessons();
    return Container(
        height: scrnlength,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(
              _screenWidth > 600 ? 100 : _screenWidth * 0.01,
              10,
              _screenWidth > 600 ? 100 : _screenWidth * 0.01,
              10),
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(10, 30, 10, 50),
                child: Text(
                  'Welcome CHILD ONE',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                )),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                'Topic : ' + data[i]['TopicTitle'],
                style: TextStyle(fontSize: 18),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.cyan.shade100,
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Text(
                  'Lesson ' +
                      (i + 1).toString() +
                      ' : ' +
                      data[i]['LessonTitle'],
                  style: TextStyle(fontSize: 18),
                )),
            Container(
                color: Colors.grey[100],
                width: double.infinity,
                alignment: Alignment.center,
                child: Container(
                  width: 160,
                  child: MaterialButton(
                    shape: CircleBorder(
                      side: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    child: AvatarGlow(
                      endRadius: 60,
                      glowColor: Colors.amber,
                      showTwoGlows: true,
                      repeat: true,
                      duration: Duration(seconds: 2),
                      animate: _animate,
                      child: Material(
                        elevation: 8.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          child: Text(
                            "START",
                          ),
                          radius: 35,
                        ),
                      ),
                    ),
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Lesson(data[i]['LessonId'])));
                    },
                  ),
                )),
            Container(
              height: 150,

              // card height
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        width: 120,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 20,
                                child: Center(
                                  child: Text("Status"),
                                )),
                            Container(
                                height: 50,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black38,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    data.isEmpty ? '' : data[i]['Status'],
                                  ),
                                )),
                          ],
                        )),
                    Container(
                        width: 120,
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 20,
                                child: Center(
                                  child: Text("Marks"),
                                )),
                            Container(
                                height: 50,
                                child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black38,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        data.isEmpty
                                            ? '0/0'
                                            : data[i]['NoOfQuestions']
                                                    .toString() +
                                                '/' +
                                                data[i]['CorrectAnswers']
                                                    .toString(),
                                      ),
                                    ))),
                          ],
                        )),
                    Container(
                        width: 120,
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 20,
                                child: Center(
                                  child: Text("Award"),
                                )),
                            Container(
                                height: 50,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black38,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    data.isEmpty
                                        ? 'No Award'
                                        : data[i]['Award'] == null
                                            ? 'No Award'
                                            : data[i]['Award'],
                                  ),
                                )),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 40, 0, 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    elevation: 6,
                    color: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                        child: Center(
                            child: Text(
                          'Missed Questions',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ))),
                  ),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                        child: Center(
                            child: Text(
                          'Practice Questions',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ))),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: NumberStepper(
                  isDone: new List<bool>.generate(
                      data.length, (index) => data[index]['LessonCompleted']),
                  scrollingDisabled: true,
                  enableNextPreviousButtons: false,

                  numbers:
                      new List<int>.generate(data.length, (index) => index + 1),

                  activeStepColor: Colors.yellow[300],
                  // activeStep property set to activeStep variable defined above.
                  activeStep: activeStep,
                  activeStepBorderColor: Colors.blue,
                  stepColor: Colors.greenAccent,
                  selectedBorder: selectedborder,
                  activeStepBorderWidth: 2,
                  // This ensures step-tapping updates the activeStep.
                  onStepReached: (index) {
                    setState(() {
                      selectedborder = index;
                      i = index;
                    });
                  },
                )),
            Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
              child: Text('Click Lesson to Start'),
            )
          ],
        ));
  }

  void getnextLesson() {
    setState(() {
      nextLesson = true;
      i = i + 1;
    });
  }

  void getperviousLesson() {
    setState(() {
      i = i - 1;
    });
  }
}

class NoLessons extends StatelessWidget {
  const NoLessons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                padding: EdgeInsets.all(10),
                color: Color.fromARGB(255, 170, 218, 174),
                child: Text(
                  "No Lessons found for this children",
                  style: TextStyle(fontSize: 20),
                ))));
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
