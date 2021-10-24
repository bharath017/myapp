import 'package:flutter/material.dart';
import 'package:myapp/models/options.dart';
import 'package:reorderables/reorderables.dart';

class DragnDrop extends StatefulWidget {
  late final List<Options> options;
  DragnDrop({Key? key, required this.options}) : super(key: key);

  @override
  _DndState createState() => new _DndState();

  static List<String> getanswer() {
    return _DndState.getAnswer();
  }
}

class _DndState extends State<DragnDrop> {
  // List<Options> options;
  List<String> data2 = [];
  static List<String> data3 = [];
  static bool sub = false;
  //@override
  void initState() {
    super.initState();
    setState(() {
      data2 = [];
      data3 = [];
    });

    for (int i = 0; i < widget.options.length; i++) {
      if (widget.options[i].isCorrect == false) {
        setState(() {
          data2.add(widget.options[i].answerOption.toString());
        });
      }
    }
  }

  @override
  void didUpdateWidget(DragnDrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (sub) {
      sub = false;
      setState(() {
        data2 = [];
        data3 = [];
      });

      for (int i = 0; i < widget.options.length; i++) {
        if (widget.options[i].isCorrect == false) {
          setState(() {
            data2.add(widget.options[i].answerOption.toString());
          });
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
          DragTarget(
            onAccept: (data) {
              if (data is String) {
                setState(() {
                  // print(data);
                  data2.add(data.toString());
                  // print("adding");
                });
              }
            },
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: bigBixwidth,
                alignment: Alignment.centerLeft,
                height: 100,
                decoration: BoxDecoration(
                    color: accepted.isEmpty
                        ? Colors.grey.shade300
                        : Colors.grey[200],
                    border: Border.all(width: 1.0, color: Colors.black45),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    )),
                child: SingleChildScrollView(
                  child: data2.length == 0
                      ? Center(
                          heightFactor: 7,
                          child: Text(
                            '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      : Wrap(children: [
                          Wrap(
                            // needsLongPressDraggable: true,
                            spacing: 9.0,
                            runSpacing: 10.0,

                            // padding: const EdgeInsets.all(8),
                            children: List.generate(
                              data2.length,
                              (index) => Draggable(
                                  onDragCompleted: () {
                                    setState(() {
                                      data2.removeAt(index);
                                      //data3.add(val);
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
                                              color: Colors.black38,
                                              offset: Offset(1, 3))
                                        ]),
                                    child: Center(
                                      child: Text(
                                        data2[index],
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
                                              color: Colors.black38,
                                              offset: Offset(1, 3))
                                        ]),
                                    child: Center(
                                      child: Text(
                                        data2[index],
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black38,
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.none),
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
                            // onReorder: _onReorder,
                            // onNoReorder: (int index) {
                            //   //this callback is optional
                            //   setState(() {
                            //     var val = data2.removeAt(index);
                            //     data3.add(val);
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
                        ]),
                ),
              );
            },
          ),
          Container(
            height: 10,
          ),
          DragTarget(
            onWillAccept: (data) {
              return true;
            },
            onAccept: (data) {
              if (data is String) {
                setState(() {
                  data3.add(data.toString());
                });
              }
            },
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.centerLeft,
                height: 100,
                width: bigBixwidth,
                decoration: BoxDecoration(
                    color: accepted.isEmpty
                        ? Colors.grey.shade300
                        : Colors.grey[200],
                    border: Border.all(width: 1.0, color: Colors.black45),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    )),
                child: SingleChildScrollView(
                  child: data3.length == 0
                      ? Center(
                          heightFactor: 6,
                          child: Text(
                            'DROP HERE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      : Wrap(children: [
                          ReorderableWrap(
                              spacing: 9.0,
                              runSpacing: 10.0,
                              // padding: const EdgeInsets.all(8),
                              children: List.generate(
                                data3.length,
                                (index) => Container(
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
                                      data3[index],
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onReorder: _onReorder1,
                              onNoReorder: (int index) {
                                //this callback is optional
                                setState(() {
                                  var val = data3.removeAt(index);
                                  data2.add(val);
                                });
                              },
                              onReorderStarted: (int index) {
                                //this callback is optional
                              }),
                        ]),
                ),
              );
            },
          ),
        ]));
  }

  static List<String> getAnswer() {
    sub = true;
    return data3;
  }
}
