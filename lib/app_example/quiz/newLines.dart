import 'package:flutter/material.dart';
import 'package:myapp/app_example/quiz/globalsd.dart';
import 'package:myapp/models/options.dart';
import 'globals.dart' as globals;
import 'package:draw_arrow/draw_arrow.dart';

//import 'globals.dart';

class Matching extends StatefulWidget {
  late List<Options> options;
  Matching({Key? key, required this.options}) : super(key: key);

  //final String title;
  static List getAnswer() {
    return _MatchState.getAnswer();
  }

  @override
  _MatchState createState() => _MatchState(options);
}

class _MatchState extends State<Matching> {
  late List<Options> options;
  _MatchState(this.options) {
    generateArray(options);
  }
  List data1 = [];

  List data2 = [];

  bool amIHovering = false;
  Offset exitFrom = Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    bool touching = false;
    int contactindex = 99;
    return Container(
      child: Container(
        height: 400,
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(children: [
              Wrap(
                direction: Axis.vertical,
                spacing: 8.0,
                runSpacing: 4.0,

                //padding: const EdgeInsets.all(8),
                children: List.generate(
                  data1.length,
                  (index) => Container(
                      child: draggablebox(option: data1[index], index: index)),
                ),
              ),
            ]),
            Column(children: [
              Wrap(
                direction: Axis.vertical, spacing: 8.0, runSpacing: 4.0,
                //padding: const EdgeInsets.all(8),
                children: List.generate(
                  data2.length,
                  (index) => DragTarget<String>(
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
                            border:
                                Border.all(width: 1, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10)),
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
                      print(index.toString() + '==' + contactindex.toString());
                    },
                    onAccept: (String data) {
                      setTarget(index);
                      setState(() {});
                    },
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }

  void generateArray(List<Options> options) {
    for (int i = 0; i < options.length; i++) {
      data1.add(options[i].answerOption!.split("=")[0]);
      data2.add(options[i].answerOption!.split("=")[1]);
    }
    data1.shuffle();
    data2.shuffle();
  }

  List mappedArray = [];
  static List answer = [];
  List<String> targetlist = new List.filled(5, '');
  void setTarget(int index) {
    int selectedsource = _DragState.getSelectedSource();
    var mapped = [selectedsource, index];
    mappedArray.add(mapped);
    setState(() {
      targetlist[selectedsource] = 'target' + index.toString();
      selectedsource = -1;
    });
    answer = generateAnswer(mappedArray);
  }

  generateAnswer(List mappedArray) {
    List answer = [];
    for (int i = 0; i < mappedArray.length; i++) {
      answer.add(data1[mappedArray[i][0]].toString() +
          "=" +
          data2[mappedArray[i][1]].toString());
    }
    print(answer);
    return answer;
  }

  static List getAnswer() {
    return answer;
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
    return Draggable(
        key: ValueKey(widget.option),
        feedback: Container(),
        data: option,
        onDragStarted: () {
          setsource(index);
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
            gl[index].ghost = true;
            gl[index].repaint = false;
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
            size: Size.infinite,
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
    // print("lalalal=" + localCentrePos.toString());
    Paint painter = Paint()
      ..color = Colors.pink
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
          Offset(gl.squarePos.dx * w, gl.squarePos.dy * h), ghostPos);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    //throw UnimplementedError();
    return gl.repaint;
  }
}
