import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:myapp/app_example/quiz/MatchTheFollowing.dart';
import 'package:myapp/app_example/quiz/dnd.dart';
import 'package:myapp/app_example/quiz/mtf.dart';
import 'package:myapp/app_example/quiz/newLines.dart';
import 'package:myapp/models/Child.dart';
import 'package:myapp/models/options.dart';
import 'package:myapp/models/quiz.dart';
import 'package:myapp/models/quiz_answers.dart';
import 'package:myapp/models/quiz_model.dart';
import 'package:myapp/models/submit_quiz.dart';
import 'package:myapp/services/LessonService.dart';
import 'package:progress_timeline/progress_timeline.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';
import 'ChildHome.dart';
import 'dragndrop.dart';
import 'quiz/dargbox.dart';
import 'quiz/mcq.dart';
import 'quiz/oddoreven.dart';
import 'quiz/oneword.dart';

/// This is the main application widget.
class QuizScreen extends StatelessWidget {
  int? lessonId;
  QuizScreen({Key? key, required this.lessonId}) : super(key: key);

  //QuizScreen(this.lessonId);
  static const String _title = 'Flutter Code Sample';
  final LessonService api = LessonService();
  SubmitQuiz quizdata = new SubmitQuiz();

  @override
  Widget build(BuildContext context) {
    QuizModel quiz;

    // print("Top=" + MediaQuery.of(context).padding.top.toString());
    // print("Bottom=" + MediaQuery.of(context).padding.bottom.toString());
    // print("Right=" + MediaQuery.of(context).padding.right.toString());
    // print("left=" + MediaQuery.of(context).padding.left.toString());

    return new Scaffold(
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Color(0x44000000),
          title: new Text(
            "Recognizing Numbers",
            textAlign: TextAlign.center,
          ),
        ), // appBar
        body: SafeArea(
          child: OrientationBuilder(builder: (context, orientation) {
            return FutureBuilder<QuizModel>(
                future: api.getQuizQuestions(lessonId!),
                builder: (context, snapshot) {
                  //print(snapshot);
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? QuizWidget(quiz: snapshot.data!)
                      : Center(child: CircularProgressIndicator());
                });
          }),
        ));
  }
}

String radioItemHolder = '';

int id = 0;
int index = 0;

/// This is the stateful widget that the main application instantiates.
class QuizWidget extends StatefulWidget {
  final QuizModel quiz;
  const QuizWidget({Key? key, required this.quiz}) : super(key: key);

  @override
  State<QuizWidget> createState() => _QuizWidgetState(quiz);
}

/// This is the private State class that goes with MyStatefulWidget.
class _QuizWidgetState extends State<QuizWidget> {
  QuizModel quiz;
  late SharedPreferences logindata;

  late int UserId;
  List<SingleState> allStages = [];
  _QuizWidgetState(this.quiz) {
    allStages = new List<SingleState>.generate(
        quiz.quiz?.length ?? 0,
        (i) => SingleState(
            stateTitle: (i + 1).toString(), isFailed: false, isChecked: false));
  }

  late ProgressTimeline screenProgress;
  late List<Quiz> questions;
  bool loaded = false;
  bool lastQuestion = false;
  double connectorlength = 0;
  double iconsize = 0;
  late List<Options> options;
  List<QuizAnswers> quizAnswers = [];
  var noOfQuestions = 0;
  int count = 0;
  final LessonService api = LessonService();

  @override
  void initState() {
    id = 0;
    index = 0;
    radioItemHolder = '';
    questions = quiz.quiz!;
    noOfQuestions = questions.length;
    var physicalScreenSize = window.physicalSize;
    var physicalWidth = physicalScreenSize.width;
    var physicalHeight = physicalScreenSize.height;
    // print(questions);
    // setState(() {});
    super.initState();
    _controller = ScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        loaded = true;
      });
    });
    initial();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int childId = 0;
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      UserId = logindata.getInt('UserId')!;
      childId = logindata.getInt('ChildId')!;
    });
  }

  late ScrollController _controller;
  @override
  Widget build(BuildContext context) {
    options = questions[index].options!;
    var _screenWidth = MediaQuery.of(context).size.width;

    var _screenHeight = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;
    var safePadding = MediaQuery.of(context).padding.left;
    var safePaddingright = MediaQuery.of(context).padding.left;

    setState(() {
      if (orientation == Orientation.landscape) {
        _screenWidth = _screenWidth - 94;
        connectorlength = ((_screenWidth / 2)) / (questions.length + 1);
      } else {
        // _screenWidth = _screenWidth + 94;
        connectorlength = ((_screenWidth / 2)) / (questions.length + 1);
      }
    });

    var pglength;

    var padlength;
    setState(() {
      iconsize = (connectorlength / 1.2);
      iconsize = iconsize > 50 ? 50 : iconsize;
      pglength = (connectorlength * (noOfQuestions - 2)) +
          (noOfQuestions * (iconsize));
      padlength = (((_screenWidth) - pglength.ceil()).abs()) / 1.3;
    });

    setprogressbar();
    screenProgress.connectorLength = connectorlength;
    screenProgress.iconSize = iconsize;

    return SingleChildScrollView(
        controller: _controller,
        //physics: NeverScrollableScrollPhysics(),
        child: Container(
            // color: Colors.blueAccent,
            // height: orientation == Orientation.portrait
            //     ? _screenHeight + 10
            //     : _screenWidth > 1000
            //         ? _screenHeight / 1.2
            //         : _screenWidth / 1,
            constraints: BoxConstraints(minHeight: _screenHeight - 70),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Text(
                      'Question Number : ' + (index + 1).toString(),
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),

                Padding(
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                    child: Center(
                        child: Text(questions[index].question!,
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)))),
                loaded == true
                    ? checkquizType(questions[index].questionType!,
                        questions[index].options!)
                    : Container(),
                // oneword(options: options),
                // dnd(options: options),
                //questions[index].questionType == 2
                //  ? DragAndDrop(options: options) :

                Container(
                    height: iconsize * 2.2,
                    // physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                        padlength / 2, 10, padlength / 2, 0),
                    alignment: Alignment.center,
                    child: Center(
                      child: screenProgress,
                    )),

                SizedBox(
                  height: orientation == Orientation.landscape
                      ? _screenWidth * 0.075
                      : _screenHeight * 0.075,
                  child: Center(
                      child: Card(
                    elevation: 4,
                    child: ListView(
                      //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed))
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
                                                ChildHome(childId)));
                                  },
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Center(
                                          child: Text(
                                        'Home',
                                        style: TextStyle(
                                            fontSize: _screenWidth * 0.029),
                                      ))),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed))
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
                                    setState(() {
                                      checkanswers(
                                          options,
                                          questions[index].questionType!,
                                          questions[index].questionId!);
                                      // index = index + 1;
                                      // options = questions[index].options!;
                                      // checkquizType(
                                      //     questions[index].questionType!, options);
                                    });
                                  },
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Center(
                                          child: Text(
                                        index + 2 <= questions.length
                                            ? 'Next'
                                            : 'Finish',
                                        style: TextStyle(
                                            fontSize: _screenWidth * 0.029),
                                      ))),
                                ),
                              ],
                            )),
                      ],
                    ),
                  )),
                )
              ],
            )));
    // });
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Caution !!'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Are you sure to skip this Question ?"),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            screenProgress.failCurrentStage();
            skipQuestion(
                questions[index].questionType!, questions[index].questionId!);
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          child: Text('Skip'),
        ),
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          child: Text('Attempt'),
        ),
      ],
    );
  }

  checkquizType(int s, List<Options> options) {
    int quiztype = s;

    if (index + 1 >= questions.length) {
      setState(() {
        lastQuestion = true;
      });
    }
    if (quiztype == 1) {
      return mcq(options: options);
    } else if (quiztype == 2) {
      DragnDrop dnd = new DragnDrop(options: options);
      return dnd;
    } else if (quiztype == 3) {
      return new oddandeven(options: options);
    } else if (quiztype == 4) {
      return oneword();
    } else if (quiztype == 5) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => MatchTheFollowing(
      //             options: options,
      //             noofQuestions: noOfQuestions,
      //             allStages: allStages)));
      //return MatchTheFollowing();
      return MatchTheFollowing2(options: options);
    }
  }

  checkanswers(List<Options> options, int type, int questionId) {
    if (type == 1) {
      int? correctanswer =
          options.firstWhere((x) => x.isCorrect == true).answerOptionId;
      int subanswer = mcq.getsubanswer();

      if (subanswer == 0) {
        showPopup();

        return false;
      } else if (correctanswer == subanswer) {
        QuizAnswers quiz = new QuizAnswers();
        quiz.answerId = correctanswer;
        quiz.answerOption = '';
        quiz.questionId = questionId;
        quiz.questionType = type;
        quizAnswers.add(quiz);
        nextQuestion();
      } else {
        screenProgress.failCurrentStage();
        nextQuestion();
      }

      setState(() {
        radioItemHolder = '';
        id = 0;
      });
    } else if (type == 2) {
      String? correctanswer =
          options.firstWhere((x) => x.isCorrect == true).answerOption;
      String ans = correctanswer.toString();
      List<String> subans = DragnDrop.getanswer();
      String sa = subans.toString();
      sa = sa.replaceAll('[', '');
      sa = sa.replaceAll(']', '');
      sa = sa.replaceAll(' ', '');

      if (sa == '') {
        showPopup();
        return false;
      } else if (ans == sa) {
        QuizAnswers quiz = new QuizAnswers();
        quiz.answerId = 0;
        quiz.answerOption = sa;
        quiz.questionId = questionId;
        quiz.questionType = type;
        quizAnswers.add(quiz);
        nextQuestion();
      } else {
        screenProgress.failCurrentStage();
        nextQuestion();
      }
    } else if (type == 3) {
      String subans = oddandeven.getanswer();
      String? correctAnswer =
          options.firstWhere((x) => x.isCorrect == true).answerOption;
      var arr = correctAnswer!.split(";");
      List<String> d1 = (arr[0].split("=")[1].split(","));
      var a1 = arr[0].split("=")[1];
      var a2 = arr[1].split("=")[1];
      String ans = a1 + ';' + a2;
      print(ans);
      d1.sort();
      List<String> d2 = (arr[1].split("=")[1].split(","));
      d2.sort();
      String answer = d1.toString() + d2.toString();
      answer = answer.replaceAll('][', ';');
      answer = answer.replaceAll('[', '');
      answer = answer.replaceAll(']', '');
      answer = answer.replaceAll(' ', '');
      if (subans == ';') {
        showPopup();
        return false;
      } else if (subans == answer) {
        QuizAnswers quiz = new QuizAnswers();
        quiz.answerId = 0;
        quiz.answerOption = ans;
        quiz.questionId = questionId;
        quiz.questionType = type;

        quizAnswers.add(quiz);
        nextQuestion();
      } else {
        screenProgress.failCurrentStage();

        nextQuestion();
      }
    } else if (type == 4) {
      String subans = oneword.getAnswer();
      String? ans = options[0].answerOption;

      if (subans == '') {
        showPopup();
        return false;
      } else if (subans == ans) {
        QuizAnswers quiz = new QuizAnswers();
        quiz.answerId = 0;
        quiz.answerOption = subans;
        quiz.questionId = questionId;
        quiz.questionType = type;

        quizAnswers.add(quiz);
        nextQuestion();
      } else {
        screenProgress.failCurrentStage();

        nextQuestion();
      }
    } else if (type == 5) {
      List subans = MatchTheFollowing2.getAnswer();
      List ans = [];

      subans.sort();
      for (int i = 0; i < options.length; i++) {
        ans.add(options[i].answerOption!);
      }
      ans.sort();

      if (subans.isEmpty) {
        showPopup();
        return false;
      } else if (listEquals(ans, subans)) {
        QuizAnswers quiz = new QuizAnswers();
        quiz.answerId = 0;
        String anss = subans.toString();
        anss = anss.replaceAll('[', '');
        anss = anss.replaceAll(']', '');
        anss = anss.replaceAll(' ', '');
        quiz.answerOption = anss;
        quiz.questionId = questionId;
        quiz.questionType = type;

        quizAnswers.add(quiz);
        nextQuestion();
      } else {
        screenProgress.failCurrentStage();
        nextQuestion();
      }
    }
  }

  nextQuestion() {
    if (!lastQuestion) {
      screenProgress.gotoNextStage();
      setState(() {
        index = index + 1;
        options = questions[index].options!;
      });
    } else {
      screenProgress.gotoNextStage();
      submitAnswer();
    }
  }

  showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildPopupDialog(context),
    );
  }

  submitAnswer() {
    api.submitQuiz(
        SubmitQuiz(
            childId: childId,
            lessonId: quiz.lessonId,
            quizType: '',
            quizAnswers: quizAnswers),
        context);
  }

  skipQuestion(int questionType, int questionId) {
    QuizAnswers quiz = new QuizAnswers();
    quiz.answerId = 0;
    quiz.answerOption = '';
    quiz.questionId = questionId;
    quiz.questionType = questionType;

    quizAnswers.add(quiz);
    screenProgress.failCurrentStage();
    nextQuestion();
  }

  void setprogressbar() {
    // allStages.forEach((SingleState) => print(SingleState.isChecked));

    if (count == 0) {
      screenProgress = new ProgressTimeline(
        states: allStages,
        iconSize: iconsize,
        connectorLength: connectorlength,
        connectorWidth: 3,
        connectorColor: Colors.lightBlue.shade200,
        textStyle: TextStyle(fontSize: iconsize / 2),
      );
      count++;
    }
  }
}

// class DragAndDrop extends StatefulWidget {
//   late List<Options> options;

//   DragAndDrop({Key? key, required this.options}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() => new _DragState(options);
// }

// class _DragState extends State<DragAndDrop> {
//   List<Options> options;
//   _DragState(this.options);
//   // List<String> data1 = ["2", "5", "9", "7"];
//   List<String> data2 = [];

//   void initState() {}

//   String image = "https://localhost:5001/src/images/";
//   @override
//   Widget build(BuildContext context) {
//     void _onReorder(int oldIndex, int newIndex) {
//       setState(() {
//         String row = data2.removeAt(oldIndex);
//         data2.insert(newIndex, row);
//       });
//     }

//     return Container(
//       child: DragTarget(
//         onAccept: (data) {
//           if (data is String) {
//             setState(() {
//               data2.add(data.toString());
//             });
//           }
//         },
//         builder: (
//           BuildContext context,
//           List<dynamic> accepted,
//           List<dynamic> rejected,
//         ) {
//           return Center(
//             child: Container(
//               height: 150.0,
//               width: 430,
//               decoration: BoxDecoration(
//                 color:
//                     accepted.isEmpty ? Colors.grey.shade300 : Colors.grey[200],
//               ),
//               child: SingleChildScrollView(
//                 child: data2.length == 0
//                     ? Center(
//                         heightFactor: 5,
//                         child: Text(
//                           'DROP HERE',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 25,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       )
//                     : Row(children: [
//                         ReorderableWrap(
//                             spacing: 8.0,
//                             runSpacing: 4.0,
//                             padding: const EdgeInsets.all(8),
//                             children: List.generate(
//                               data2.length,
//                               (index) => Container(
//                                 height: 95,
//                                 width: 95,
//                                 padding: EdgeInsets.all(10.0),
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(width: 1.0),
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(10.0),
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           blurRadius: 10,
//                                           color: Colors.black54,
//                                           offset: Offset(1, 3))
//                                     ]),
//                                 child: Center(
//                                   child: Text(
//                                     data2[index],
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             onReorder: _onReorder,
//                             onNoReorder: (int index) {
//                               var it = data2.removeAt(index);
//                               //DragBoxState.addItem(it);
//                             },
//                             onReorderStarted: (int index) {
//                               //this callback is optional
//                               debugPrint(
//                                   '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
//                             }),
//                       ]),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
