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

class MatchTheFollowing2 extends StatefulWidget {
  List<Options> options;

  MatchTheFollowing2({
    Key? key,
    required this.options,
  }) : super(key: key);

  @override
  _MatchTheFollowingState createState() => _MatchTheFollowingState();

  static List getAnswer() {
    return _MatchTheFollowingState.getAnswer();
  }
}

class _MatchTheFollowingState extends State<MatchTheFollowing2> {
  bool showArrows = true;
  //_MatchTheFollowingState(this.options);
  //List<Options> options;
  // late int quizLength = widget.noofQuestions;

  static late ScrollController _controller;
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

  static bool sub = false;
  @override
  void didUpdateWidget(MatchTheFollowing2 oldWidget) {
    if (sub) {
      sub = false;
      super.didUpdateWidget(oldWidget);
      print("updating");
      setState(() {
        gl = [];
        gl = [globalsd(), globalsd(), globalsd(), globalsd()];
        gl.forEach((element) {
          element.ghost = false;
        });
        data1 = [];
        data2 = [];
        mappedArray = [];
        mapped1 = [];
        mapped2 = [];
        answer = [];
        targetlist = new List.filled(4, '');
        mappedIndex1 = [];
        mappedIndex2 = [];
        for (int i = 0; i < widget.options.length; i++) {
          data1.add(widget.options[i].answerOption!.split("=")[0]);
          data2.add(widget.options[i].answerOption!.split("=")[1]);
        }
        data1.shuffle();
        data2.shuffle();

        // generateArray(widget.options);
      });
    }
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
  double someval = 0.1;
  @override
  Widget build(BuildContext context) {
    //var noOfQuestions = quizLength;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;

    var pglength;

    var padlength;
    setState(() {});
    var safePadding = MediaQuery.of(context).padding.right;
    return Container(
        height: 400,
        // width: 400,
        // color: Colors.green,
        alignment: Alignment.topRight,
        child: ArrowContainer(
          con: context,
          child: Container(
            // height: orientation == Orientation.portrait
            //     ? _screenHeight / 2.2
            //     : _screenWidth > 1000
            //         ? _screenHeight / 1.2
            //         : _screenWidth / 2.2,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    //width: 400,
                    // height: 370,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(
                        _screenWidth > 600 ? 200 : _screenWidth * 0.05,
                        10,
                        _screenWidth > 600 ? 200 : _screenWidth * 0.05,
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
                                      show: showArrows,
                                      id: 'source' + index.toString(),
                                      targetIds: [targetlist[index]],
                                      sourceAnchor: Alignment.centerRight,
                                      color: Colors.black,
                                      arcDirection: ArcDirection.Left,
                                      bow: 0.0,
                                      stretch: 0.0,
                                      tipLength: 10,
                                      straights: true,
                                      cont: context,
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        child: draggablebox(
                                            option: data1[index],
                                            index: index,
                                            gl: gl[index]),
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
                                      id: 'target' + index.toString(),
                                      sourceAnchor: Alignment.centerLeft,
                                      // color: Colors.greenAccent[100],
                                      bow: 0.0,
                                      cont: context,
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
                                                  color: index == contactindex
                                                      ? Colors.grey.shade300
                                                      : Colors.white,
                                                  border: Border.all(
                                                      width: 1,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(data2[index]),
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
                                            setState(() {
                                              // _controller.animateTo(
                                              //     _controller.offset + 0.5,
                                              //     curve: Curves.linear,
                                              //     duration:
                                              //         Duration(milliseconds: 500));

                                              setTarget(index);

                                              // someval = someval + 0.1;
                                            });
                                          },
                                        ),
                                      ),
                                    )),
                          )
                        ]),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  static int selectedsource = -1;
  final LessonService api = LessonService();
  List<String> targetlist = new List.filled(4, '');
  List mappedIndex1 = [];
  List mappedIndex2 = [];

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
    sub = true;

    return answer;
  }

  List<QuizAnswers> quizAnswers = [];
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
  globalsd gl;
  draggablebox(
      {Key? key, required this.option, required this.index, required this.gl})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => new _DragState(option, index, gl);
}

class _DragState extends State<draggablebox> {
  String option;
  int index;
  globalsd gl;
  @override
  void didUpdateWidget(draggablebox oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  clearLines() {
    // gl = [globalsd(), globalsd(), globalsd(), globalsd()];
  }

  _DragState(this.option, this.index, this.gl);

  @override
  Widget build(BuildContext context) {
    _MatchTheFollowingState cll = new _MatchTheFollowingState();
    return Draggable(
        key: ValueKey(widget.option),
        feedback: Container(),
        data: widget.option,
        onDragStarted: () {
          cll.setthesource(index);
          widget.gl.ghost = true;
        },
        onDragUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox object = context.findRenderObject() as RenderBox;
            Offset pos = object.localToGlobal(Offset.zero);

            Offset off = Offset(pos.dx, (pos.dy));

            widget.gl.tapPos = details.localPosition - off;
            widget.gl.repaint = true;
          });
        },
        onDragEnd: (DraggableDetails details) {
          setState(() {
            widget.gl.ghost = false;
            widget.gl.repaint = true;
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
            painter: UIPainter(widget.gl),
            size: Size.fromRadius(40),
            child: Center(
              child: Text(widget.option),
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
