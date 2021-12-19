import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/models/options.dart';
import 'package:reorderables/reorderables.dart';

class oddandeven extends StatefulWidget {
  late List<Options> options;

  oddandeven({Key? key, required this.options}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _OddnEvenState();

  static String getanswer() {
    return _OddnEvenState.getAnswer();
  }
}

class _OddnEvenState extends State<oddandeven> {
  // List<Options> options;
  _OddnEvenState() {
    print("calling here");
  }

  static List<String> data2 = [];
  static List<String> data3 = [];
  String category1 = '';
  String category2 = '';
  Offset position = Offset(0.0, 0.0);
  List<String> data1 = [];
  static bool sub = false;
  String correctAnswer = '';
  @override
  void initState() {
    super.initState();

    // position = widget.initPos;
    setState(() {
      data1 = [];
      data2 = [];
      data3 = [];
    });
    print("inside init");
    for (int i = 0; i < widget.options.length; i++) {
      if (widget.options[i].isCorrect == false) {
        setState(() {
          data1.add(widget.options[i].answerOption.toString());
        });
      } else if (widget.options[i].isCorrect == true) {
        correctAnswer = widget.options[i].answerOption.toString();
      }
    }
  }

  @override
  void didUpdateWidget(oddandeven oldWidget) {
    print("trying");
    if (sub) {
      sub = false;
      super.didUpdateWidget(oldWidget);
      setState(() {
        data1 = [];
        data2 = [];
        data3 = [];
      });
      print("inside update");
      //position = widget.initPos;

      for (int i = 0; i < widget.options.length; i++) {
        if (widget.options[i].isCorrect == false) {
          setState(() {
            data1.add(widget.options[i].answerOption.toString());
          });
        }
      }
    }
  }

  bool inc = false;
  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        String row = data2.removeAt(oldIndex);
        data2.insert(newIndex, row);
      });
    }

    void _onReorder1(int oldIndex, int newIndex) {
      setState(() {
        String row = data3.removeAt(oldIndex);
        data3.insert(newIndex, row);
      });
    }

    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;
    _screenWidth = orientation == Orientation.landscape
        ? _screenHeight - 20
        : _screenWidth - 20;

    double bigBixwidth = _screenWidth < 400 ? _screenWidth : 400;
    double smallBox = bigBixwidth / 4.9;
    return Container(
        child: Column(children: [
      DragTarget(
        onAccept: (data) {
          if (data is String) {
            setState(() {
              // print(data);
              data1.add(data.toString());

              // print("adding");
            });
          }
        },
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  //  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  height: data1.length > 4 ? 220 : 110,
                  width: bigBixwidth,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: accepted.isEmpty
                          ? Colors.grey.shade300
                          : Colors.grey[200],
                      border: Border.all(width: 1.0, color: Colors.black45),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      )),
                  child: SingleChildScrollView(
                    child: Wrap(children: [
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        // padding: const EdgeInsets.all(8),
                        children: List.generate(
                          data1.length,
                          (index) => Draggable(
                              onDragCompleted: () {
                                setState(() {
                                  var val = data1.removeAt(index);
                                  // data3.add(val);
                                });
                              },
                              childWhenDragging: Container(
                                height: smallBox,
                                width: smallBox,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    border: Border.all(width: 1.0),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.black54,
                                          offset: Offset(1, 3))
                                    ]),
                                child: Center(
                                  child: Text(
                                    data1[index],
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              ),
                              feedback: Container(
                                height: 80,
                                width: 80,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1.0),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.black54,
                                          offset: Offset(1, 3))
                                    ]),
                                child: Center(
                                  child: Text(
                                    data1[index],
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              ),
                              data: data1[index],
                              child: Container(
                                height: smallBox,
                                width: smallBox,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1.0),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.black54,
                                          offset: Offset(1, 3))
                                    ]),
                                child: Center(
                                  child: Text(
                                    data1[index],
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ]),
                  ),
                ),
              ]);
        },
      ),
      Container(
          width: bigBixwidth + 20,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            DragTarget(
              onAccept: (data) {
                if (data is String) {
                  setState(() {
                    // print(data);
                    data2.add(data.toString());
                    if (data3.length > 2 || data2.length > 2) {
                      inc = true;
                    } else {
                      inc = false;
                    }
                    // print("adding");
                  });
                }
              },
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: bigBixwidth / 2,
                          child: (Text(
                            correctAnswer.split(";")[0].split("=")[0],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          height: inc ? (smallBox + 20) * 2 : smallBox + 22,
                          width: bigBixwidth / 2,
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              color: accepted.isEmpty
                                  ? Colors.grey.shade300
                                  : Colors.grey[200],
                              border:
                                  Border.all(width: 1.0, color: Colors.black45),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                          child: SingleChildScrollView(
                            child: data2.length == 0
                                ? Center(
                                    heightFactor: 2.5,
                                    child: Text(
                                      'DROP ODD VALUE HERE',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  )
                                : Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,

                                    // padding: const EdgeInsets.all(8),
                                    children: List.generate(
                                      data2.length,
                                      (index) => Draggable(
                                          onDragCompleted: () {
                                            setState(() {
                                              var val = data2.removeAt(index);
                                              // data3.add(val);
                                              if (data3.length > 2 ||
                                                  data2.length > 2) {
                                                inc = true;
                                              } else {
                                                inc = false;
                                              }
                                            });
                                          },
                                          feedback: Container(
                                            height: 75,
                                            width: 75,
                                            padding: EdgeInsets.all(2.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(width: 1.0),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 10,
                                                      color: Colors.black38,
                                                      offset: Offset(1, 3))
                                                ]),
                                            child: Center(
                                              child: Text(
                                                data2[index],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black38,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ),
                                          ),
                                          childWhenDragging: Container(
                                            height: smallBox,
                                            width: smallBox,
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white70,
                                                border: Border.all(width: 1.0),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 10,
                                                      color: Colors.black38,
                                                      offset: Offset(1, 3))
                                                ]),
                                            child: Center(
                                              child: Text(
                                                data2[index],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black38,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ),
                                          ),
                                          data: data2[index],
                                          child: Container(
                                            height: smallBox,
                                            width: smallBox,
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(width: 1.0),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 10,
                                                      color: Colors.black54,
                                                      offset: Offset(1, 3))
                                                ]),
                                            child: Center(
                                              child: Text(
                                                data2[index],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                          ),
                        ),
                      ]),
                    ]);
              },
            ),
            DragTarget(
              onWillAccept: (data) {
                return true;
              },
              onAccept: (data) {
                if (data is String) {
                  setState(() {
                    data3.add(data.toString());
                    if (data3.length > 2 || data2.length > 2) {
                      inc = true;
                    } else {
                      inc = false;
                    }
                  });
                }
              },
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: bigBixwidth / 2,
                          child: (Text(
                            correctAnswer.split(";")[1].split("=")[0],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          height: inc ? (smallBox + 20) * 2 : smallBox + 22,
                          width: bigBixwidth / 2,
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              color: accepted.isEmpty
                                  ? Colors.grey.shade300
                                  : Colors.grey[200],
                              border:
                                  Border.all(width: 1.0, color: Colors.black45),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                          child: SingleChildScrollView(
                            child: data3.length == 0
                                ? Center(
                                    heightFactor: 2.5,
                                    child: Text(
                                      'DROP EVEN VALUE HERE',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  )
                                : Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,

                                    // padding: const EdgeInsets.all(8),
                                    children: List.generate(
                                      data3.length,
                                      (index) => Draggable(
                                          onDragCompleted: () {
                                            setState(() {
                                              var val = data3.removeAt(index);
                                              // data3.add(val);
                                              if (data3.length > 2 ||
                                                  data2.length > 2) {
                                                inc = true;
                                              } else {
                                                inc = false;
                                              }
                                            });
                                          },
                                          childWhenDragging: Container(
                                            height: smallBox,
                                            width: smallBox,
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white70,
                                                border: Border.all(width: 1.0),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 10,
                                                      color: Colors.black54,
                                                      offset: Offset(1, 3))
                                                ]),
                                            child: Center(
                                              child: Text(
                                                data3[index],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black38,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ),
                                          ),
                                          feedback: Container(
                                            height: 75,
                                            width: 75,
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(width: 1.0),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 10,
                                                      color: Colors.black38,
                                                      offset: Offset(1, 3))
                                                ]),
                                            child: Center(
                                              child: Text(
                                                data3[index],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black38,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ),
                                          ),
                                          data: data3[index],
                                          child: Container(
                                            height: smallBox,
                                            width: smallBox,
                                            padding: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(width: 1.0),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 10,
                                                      color: Colors.black54,
                                                      offset: Offset(1, 3))
                                                ]),
                                            child: Center(
                                              child: Text(
                                                data3[index],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          )),
                                    ),
                                    // onReorder: _onReorder1,
                                    // onNoReorder: (int index) {
                                    //   //this callback is optional
                                    //   setState(() {
                                    //     var val = data3.removeAt(index);
                                    //     // data2.add(val);
                                    //   });
                                    //   debugPrint(
                                    //       '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
                                    // },
                                    // onReorderStarted: (int index) {
                                    //   //this callback is optional
                                    //   debugPrint(
                                    //       '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
                                    // }
                                  ),
                          ),
                        ),
                      ])
                    ]);
              },
            ),
          ]))
    ]));
  }

  static String getAnswer() {
    data2.sort();
    data3.sort();

    String answer = data2.toString();
    answer = answer + data3.toString();
    answer = answer.replaceAll('][', ';');
    answer = answer.replaceAll('[', '');
    answer = answer.replaceAll(']', '');
    answer = answer.replaceAll(' ', '');
    print(answer);
    sub = true;
    return answer;
  }
}
