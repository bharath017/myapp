import 'package:drag_and_drop_gridview/devdrag.dart';

import 'package:flutter/material.dart';
import 'package:myapp/app_example/Quiz.dart';
import 'package:myapp/app_example/dragndrop2.dart';
import 'package:myapp/models/quiz.dart';
import 'package:progress_timeline/progress_timeline.dart';
import 'package:reorderables/reorderables.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../data/data.dart';
import 'BoardItemObject.dart';
import 'BoardListObject.dart';

class DraggableBasicPage extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<DraggableBasicPage> {
  final double _iconSize = 90;
  late List<Widget> _tiles;

  @override
  void initState() {
    screenProgress = new ProgressTimeline(
      states: allStages,
      iconSize: 30,
      connectorLength: 50,
      checkedIcon: Icon(Icons.check_box),
    );
    super.initState();
  }

  List<String> data1 = ["2", "5", "9", "7"];
  List<String> data2 = [];

  int variableSet = 0;
  ScrollController? _scrollController;
  double? width;
  double? height;
  late ProgressTimeline screenProgress;

  List<SingleState> allStages = [
    SingleState(stateTitle: "1"),
    SingleState(stateTitle: "2"),
    SingleState(stateTitle: "3"),
    SingleState(stateTitle: "4"),
    SingleState(stateTitle: "5"),
  ];

  List<BoardItemObject> listdata = [
    BoardItemObject(title: "item one "),
    BoardItemObject(title: "item two "),
    BoardItemObject(title: "item three "),
  ];
  List<BoardListObject> _listData = [
    BoardListObject(title: "List title 1", items: [
      BoardItemObject(title: "item one "),
      BoardItemObject(title: "item two "),
    ]),
    BoardListObject(title: "List title 2", items: [
      BoardItemObject(title: "item three "),
      BoardItemObject(title: "item four "),
    ]),
    BoardListObject(title: "List title 3", items: [
      BoardItemObject(title: "item five "),
      BoardItemObject(title: "item six "),
    ])
  ];

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        String row = data2.removeAt(oldIndex);
        data2.insert(newIndex, row);
      });
    }

    return MaterialApp(
        home: Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.purple,
              title: new Text("Quiz Page"),
            ),
            body: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                    child: Text(
                      "Arrange the below in ascending order",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    )),
                Positioned(
                  top: 200,
                  child: Container(
                    child: DragTarget(
                      onAccept: (data) {
                        if (data is String) {
                          setState(() {
                            data1.add(data.toString());
                          });
                        }
                      },
                      builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return Center(
                          child: Container(
                            height: 150.0,
                            width: 430,
                            decoration: BoxDecoration(
                              color: accepted.isEmpty
                                  ? Colors.grey.shade300
                                  : Colors.grey[200],
                            ),
                            child: SingleChildScrollView(
                              child: Row(children: [
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 4.0,
                                  //padding: const EdgeInsets.all(8),
                                  children: List.generate(
                                      data1.length,
                                      (index) => Draggable(
                                            feedback: Container(
                                              height: 40,
                                            ),
                                            onDragCompleted: () {
                                              data1.removeAt(index);
                                            },
                                            data: data1[index],
                                            child: Container(
                                              height: 90,
                                              width: 90,
                                              padding: EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border:
                                                      Border.all(width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                            ),
                                          )),
                                ),
                              ]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  height: 50,
                ),
                Container(
                  child: DragTarget(
                    onAccept: (data) {
                      if (data is String) {
                        setState(() {
                          data2.add(data.toString());
                        });
                      }
                    },
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return Center(
                        child: Container(
                          height: 150.0,
                          width: 430,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: accepted.isEmpty
                                ? Colors.grey.shade300
                                : Colors.grey[200],
                          ),
                          child: SingleChildScrollView(
                            child: data2.length == 0
                                ? Center(
                                    heightFactor: 5,
                                    child: Text(
                                      'DROP HERE',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  )
                                : Row(children: [
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 4.0,
                                      //padding: const EdgeInsets.all(8),
                                      children: List.generate(
                                          data2.length,
                                          (index) => Draggable(
                                                feedback: Container(
                                                  height: 40,
                                                ),
                                                onDragCompleted: () {
                                                  data2.removeAt(index);
                                                },
                                                data: data1[index],
                                                child: Container(
                                                  height: 90,
                                                  width: 90,
                                                  padding: EdgeInsets.all(10.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10.0),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 10,
                                                            color:
                                                                Colors.black54,
                                                            offset:
                                                                Offset(1, 3))
                                                      ]),
                                                  child: Center(
                                                    child: Text(
                                                      data2[index],
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                    ),
                                  ]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                    height: 100,
                    child: Card(
                      elevation: 4,
                      child: ListView(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    onPressed: () {},
                                    child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Center(
                                            child: Text(
                                          'Home',
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
                                        //index = index + 1;
                                      });
                                    },
                                    child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Center(
                                            child: Text(
                                          'Next',
                                        ))),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )),
              ],
            )));
  }
}

// class DragBox extends StatefulWidget {
//   @override
//   DragBoxState createState() => DragBoxState();
// }

// class DragBoxState extends State<DragBox> {
//   Offset position = Offset(0.0, 0.0);
//   List<String> data1 = ["5", "2", "9", "7"];
//   @override
//   void initState() {
//     super.initState();
//     //position = widget.initPos;
//   }

//   @override
//   Widget build(BuildContext context) {
//     void _onReorder(int oldIndex, int newIndex) {
//       setState(() {
//         String row = data1.removeAt(oldIndex);
//         data1.insert(newIndex, row);
//       });
//     }

//     return Container();
//   }
// }
