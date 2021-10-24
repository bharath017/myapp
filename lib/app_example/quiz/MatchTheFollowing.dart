import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/ModifiedPackages/DrawArrow/arrows.dart';
import 'package:myapp/ModifiedPackages/DrawArrow/widget_arrows.dart';
import 'package:myapp/app_example/quiz/MatchService.dart';
import 'package:myapp/app_example/quiz/globalsd.dart';
import 'package:myapp/app_example/quiz/newLines.dart';
import 'package:myapp/models/options.dart';
import 'package:myapp/models/quiz.dart';
import 'package:myapp/models/quiz_answers.dart';
import 'package:myapp/models/quiz_model.dart';
import 'package:myapp/models/submit_quiz.dart';
import 'package:myapp/services/LessonService.dart';
import 'package:progress_timeline/progress_timeline.dart';

import 'package:draw_arrow/draw_arrow.dart';

import '../Quiz.dart';

class MatchTheFollowing extends StatefulWidget {
  List<Options> options;
  int noofQuestions;
  List<SingleState> allStages;
  MatchTheFollowing(
      {Key? key,
      required this.options,
      required this.noofQuestions,
      required this.allStages})
      : super(key: key);

  @override
  _MatchTheFollowingState createState() => _MatchTheFollowingState();

  static List getAnswer() {
    return _MatchTheFollowingState.getAnswer();
  }
}

class _MatchTheFollowingState extends State<MatchTheFollowing> {
  bool showArrows = true;
  //_MatchTheFollowingState(this.options);
  //List<Options> options;
  late int quizLength = widget.noofQuestions;

  late ScrollController _controller;
  @override
  void initState() {
    // MatchService match = new MatchService();
    //match.generateArray(options);
    _controller = ScrollController();

    generateArray(widget.options);
    // allStages = new List<SingleState>.generate(
    //     quizLength,
    //     (i) => SingleState(
    //         stateTitle: (i + 1).toString(), isFailed: false, isChecked: false));
    super.initState();
  }

  List data1 = [];
  List<globalsd> gl = [globalsd(), globalsd(), globalsd(), globalsd()];
  List data2 = [];
  bool touching = false;
  int contactindex = 99;
  bool lastQuestion = false;
  double connectorlength = 0;
  double iconsize = 0;

  int count = 0;

  List mappedArray = [];
  static List answer = [];
  List mapped1 = [];
  List mapped2 = [];

  late ProgressTimeline screenProgress;
  List<SingleState> allStages = [];
  double someval = 0.1;
  @override
  Widget build(BuildContext context) {
    //var noOfQuestions = quizLength;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;
    setState(() {
      if (orientation == Orientation.landscape) {
        _screenWidth = _screenWidth - 94;
        connectorlength = ((_screenWidth / 2)) / (quizLength + 1);
      } else {
        _screenWidth = _screenWidth - 16;
        connectorlength = ((_screenWidth / 2)) / (quizLength + 1);
      }
    });

    var pglength;

    var padlength;
    setState(() {
      iconsize = (connectorlength / 1.2);
      iconsize = iconsize > 50 ? 50 : iconsize;
      pglength =
          (connectorlength * (quizLength - 2)) + (quizLength * (iconsize));
      padlength = (((_screenWidth) - pglength.ceil()).abs()) / 1.3;
    });

    setprogressbar();
    screenProgress.connectorLength = connectorlength;
    screenProgress.iconSize = iconsize;

    return ArrowContainer(
        con: context,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Text("Recognizing Numbers"),
            ), // appBar
            body: SafeArea(
              child: SingleChildScrollView(
                controller: _controller,
                child: Container(
                  height: orientation == Orientation.portrait
                      ? _screenHeight / 1.2
                      : _screenWidth > 1000
                          ? _screenHeight / 1.2
                          : _screenWidth / 1.1,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 25,
                          child: ListTile(
                            leading: Text(
                              'Question Number : ' + (1).toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                          child: Center(
                            child: Text(
                              'Match the following',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                _screenWidth > 500 ? 200 : _screenWidth * 0.05,
                                10,
                                _screenWidth > 500 ? 200 : _screenWidth * 0.05,
                                10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(children: [
                                  Wrap(
                                    direction: Axis.vertical,
                                    spacing: 8.0,
                                    runSpacing: 1.0,

                                    //padding: const EdgeInsets.all(8),
                                    children: List.generate(
                                        data1.length,
                                        (index) => ArrowElement(
                                              cont: context,
                                              show: showArrows,
                                              id: 'source' + index.toString(),
                                              targetIds: [targetlist[index]],
                                              sourceAnchor:
                                                  Alignment.centerRight,
                                              color: Colors.black,
                                              arcDirection: ArcDirection.Left,
                                              bow: 0.0,
                                              stretch: 0.0,
                                              tipLength: 10,
                                              straights: true,
                                              child: Container(
                                                height: 80,
                                                width: 80,
                                                child: draggablebox(
                                                    option: data1[index],
                                                    index: index),
                                              ),
                                            )),
                                  )
                                ]),
                                Column(children: [
                                  Wrap(
                                    direction: Axis.vertical,
                                    spacing: 8.0,
                                    runSpacing: 4.0,
                                    //padding: const EdgeInsets.all(8),
                                    children: List.generate(
                                        data2.length,
                                        (index) => ArrowElement(
                                              show: true,
                                              cont: context,
                                              id: 'target' + index.toString(),
                                              sourceAnchor:
                                                  Alignment.centerLeft,
                                              //  color: Colors.greenAccent[100],
                                              bow: 0.0,
                                              stretch: 0.0,
                                              straights: true,
                                              child: Container(
                                                height: 80,
                                                width: 80,
                                                child: DragTarget<String>(
                                                  builder: (
                                                    BuildContext context,
                                                    List<dynamic> accepted,
                                                    List<dynamic> rejected,
                                                  ) {
                                                    return Container(
                                                      height: 80.0,
                                                      width: 80.0,
                                                      decoration: BoxDecoration(
                                                          color: index ==
                                                                  contactindex
                                                              ? Colors
                                                                  .grey.shade300
                                                              : Colors.white,
                                                          border: Border.all(
                                                              width: 1,
                                                              style: BorderStyle
                                                                  .solid),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Center(
                                                        child:
                                                            Text(data2[index]),
                                                      ),
                                                    );
                                                  },
                                                  onMove: (details) {
                                                    setState(() {
                                                      touching = true;
                                                      contactindex = index;
                                                    });
                                                  },
                                                  onAccept: (String data) {
                                                    _controller.animateTo(
                                                        _controller.offset +
                                                            0.5,
                                                        curve: Curves.linear,
                                                        duration: Duration(
                                                            milliseconds: 500));

                                                    setTarget(index);
                                                    setState(() {
                                                      someval = someval + 0.1;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )),
                                  )
                                ]),
                              ],
                            )),
                        Container(

                            // physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(
                                padlength / 2, 10, padlength / 2, 10),
                            alignment: Alignment.center,
                            height: 100,
                            child: Center(
                              child: screenProgress,
                            )),
                        SizedBox(
                          height: 80,
                          child: Center(
                              child: Card(
                            elevation: 4,
                            child: ListView(
                              //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              children: [
                                Container(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.pressed))
                                                  return Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.5);
                                                else if (states.contains(
                                                    MaterialState.disabled))
                                                  return Colors.grey.shade200;
                                                return Color(
                                                    0xff39A2DB); // Use the component's default.
                                              },
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              child: Center(
                                                  child: Text(
                                                'Home',
                                              ))),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.pressed))
                                                  return Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.5);
                                                else if (states.contains(
                                                    MaterialState.disabled))
                                                  return Colors.grey.shade200;
                                                return Color(
                                                    0xff39A2DB); // Use the component's default.
                                              },
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              checkanswers(
                                                  widget.options, 5, 103);
                                              // index = index + 1;
                                              // options = questions[index].options!;
                                              // checkquizType(
                                              //     questions[index].questionType!, options);
                                            });
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              child: Center(
                                                  child: Text(
                                                index + 2 <= quizLength
                                                    ? 'Next'
                                                    : 'Finish',
                                              ))),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          )),
                        )
                      ]),
                ),
              ),
            )));
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
            skipQuestion(5, 7);
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

  static int selectedsource = -1;
  final LessonService api = LessonService();
  List<String> targetlist = new List.filled(4, '');
  List mappedIndex1 = [];
  List mappedIndex2 = [];

  void setprogressbar() {
    if (count == 0) {
      screenProgress = new ProgressTimeline(
        states: widget.allStages,
        iconSize: iconsize,
        connectorLength: connectorlength,
        connectorWidth: 3,
        connectorColor: Colors.lightBlue.shade200,
      );
      count++;
    }
  }

  void setthesource(int index) {
    selectedsource = index;
  }

  void setTarget(int index) {
    var mapped = [selectedsource, index];
    bool found = true;
    if (mappedArray.length == 0) {
      mapped1.add(selectedsource);
      mapped2.add(index);
      found = true;
      setState(() {
        mappedArray.add(mapped);
        targetlist[selectedsource] = 'target' + index.toString();
        selectedsource = -1;
      });
    } else {
      for (int i = 0; i < mappedArray.length; i++) {
        if (mappedArray[i][0] == selectedsource) {
          setState(() {
            targetlist[mappedArray[i][0]] = '';
            targetlist[selectedsource] = 'target' + index.toString();
            mappedArray.removeAt(i);
          });
          break;
        }
      }

      for (int i = 0; i < mappedArray.length; i++) {
        if (mappedArray[i][1] == index) {
          found = true;
          setState(() {
            targetlist[selectedsource] = 'target' + index.toString();
            targetlist[mappedArray[i][0]] = '';
            mappedArray.removeAt(i);

            mappedArray.add(mapped);
          });

          break;
        } else {
          found = false;
        }
      }
    }
    if (!found) {
      setState(() {
        mappedArray.add(mapped);

        targetlist[selectedsource] = 'target' + index.toString();
        selectedsource = -1;
      });
    }

    answer = generateAnswer(mappedArray);
  }

  generateAnswer(List mappedArray) {
    List answer = [];
    for (int i = 0; i < mappedArray.length; i++) {
      answer.add(data1[mappedArray[i][0]].toString() +
          "=" +
          data2[mappedArray[i][1]].toString());
    }

    return answer;
  }

  void generateArray(List<Options> options) {
    for (int i = 0; i < options.length; i++) {
      data1.add(options[i].answerOption!.split("=")[0]);
      data2.add(options[i].answerOption!.split("=")[1]);
    }
    data1.shuffle();
    data2.shuffle();
  }

  static List getAnswer() {
    return answer;
  }

  checkanswers(List<Options> options, int type, int questionId) {
    if (type == 5) {
      List subans = Matching.getAnswer();
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
        nextQuestion();
      } else {
        screenProgress.failCurrentStage();
        nextQuestion();
      }
      QuizAnswers quiz = new QuizAnswers();
      quiz.answerId = 0;
      String anss = subans.toString();
      anss = anss.replaceAll('[', '');
      anss = anss.replaceAll(']', '');
      quiz.answerOption = anss;
      quiz.questionId = questionId;
      quiz.questionType = type;

      quizAnswers.add(quiz);
    }
  }

  List<QuizAnswers> quizAnswers = [];
  // List<Options> options;
  nextQuestion() {
    if (!lastQuestion) {
      screenProgress.gotoNextStage();
      setState(() {
        index = index + 1;
        // options = questions[index].options!;
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
            childId: 3,
            lessonId: 13,
            quizType: 'mastery',
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
}

class UIPainter extends CustomPainter {
  double _abs(double a) {
    return a > 0 ? a : -a;
  }

  globalsd gl;
  UIPainter(this.gl);

  @override
  void paint(Canvas canvas, Size size) {
    gl.repaint = false;
    double h = size.height;
    double w = size.width;

    Offset localCentrePos = Offset(gl.squarePos.dx * w, gl.squarePos.dy * h);

    Paint painter = Paint()
      ..color = Colors.black
      ..blendMode = BlendMode.srcOver
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    //circle in centre
    // canvas.drawCircle(localCentrePos, 5, painter);

    if (gl.ghost) {
      //tap pos oposite to drawPos
      double x = _abs(gl.tapPos.dx - localCentrePos.dx);
      x = localCentrePos.dx + (gl.tapPos.dx > localCentrePos.dx ? x : -x);
      double y = _abs(gl.tapPos.dy - localCentrePos.dy);
      y = localCentrePos.dy + (gl.tapPos.dy > localCentrePos.dy ? y : -y);
      Offset ghostPos = Offset(x, y);

      //draw
      canvas.drawArrow(
          Offset(gl.squarePos.dx * w, gl.squarePos.dy * h), ghostPos,
          width: 2, painter: painter);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    //throw UnimplementedError();
    return gl.repaint;
  }
}

class draggablebox extends StatefulWidget {
  String option;
  int index;
  draggablebox({Key? key, required this.option, required this.index})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => new _DragState(option, index);
}

class _DragState extends State<draggablebox> {
  String option;
  int index;
  _DragState(this.option, this.index);
  List<globalsd> gl = [globalsd(), globalsd(), globalsd(), globalsd()];
  @override
  Widget build(BuildContext context) {
    _MatchTheFollowingState cll = new _MatchTheFollowingState();
    return Draggable(
        key: ValueKey(widget.option),
        feedback: Container(),
        data: option,
        onDragStarted: () {
          cll.setthesource(index);
          gl[index].ghost = true;
        },
        onDragUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox object = context.findRenderObject() as RenderBox;
            Offset pos = object.localToGlobal(Offset.zero);

            Offset off = Offset(pos.dx, (pos.dy));

            gl[index].tapPos = details.localPosition - off;
            gl[index].repaint = true;
          });
        },
        onDragEnd: (details) {
          setState(() {
            gl[index].ghost = false;
            gl[index].repaint = true;
          });
        },
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              border: Border.all(width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.centerRight,
          child: CustomPaint(
            painter: UIPainter(gl[index]),
            size: Size.fromRadius(40),
            child: Center(
              child: Text(option),
            ),
          ),
        ));
  }

  static int selectedsource = -1;

  void setsource(int index) {
    setState(() {
      selectedsource = index;
    });
  }

  static int getSelectedSource() {
    return selectedsource;
  }
}
