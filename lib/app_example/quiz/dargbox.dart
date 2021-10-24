import 'package:flutter/material.dart';
import 'package:myapp/models/options.dart';

class DragBox extends StatefulWidget {
  late List<Options> options;
  DragBox({Key? key, required this.options}) : super(key: key);
  @override
  DragBoxState createState() => DragBoxState(options);
}

class DragBoxState extends State<DragBox> {
  late List<Options> options;
  DragBoxState(this.options);

  Offset position = Offset(0.0, 0.0);
  List<String> data1 = [];
  @override
  void initState() {
    super.initState();
    //position = widget.initPos;
    {
      for (int i = 0; i < options.length; i++) {
        if (options[i].isCorrect == false) {
          data1.add(options[i].answerOption.toString());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 420.0,
        height: 120.0,
        alignment: Alignment.center,
        child: Container(
          width: 400.0,
          height: 110.0,
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border.all(width: 1.0, color: Colors.black38),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10, color: Colors.black12, offset: Offset(1, 3))
              ]),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(data1.length, (index) {
                return Container(
                    height: 80,
                    width: 80,
                    child: Draggable(
                      data: data1[index],
                      child: Container(
                          height: 80,
                          width: 80,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(width: 1.0, color: Colors.black45),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black12,
                                    offset: Offset(1, 3))
                              ]),
                          child: Center(
                            child: Text(
                              data1[index],
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 18.0,
                              ),
                            ),
                          )),
                      onDraggableCanceled: (velocity, offset) {
                        setState(() {
                          //position = offset;
                        });
                      },
                      onDragCompleted: () {
                        setState(() {
                          data1.removeAt(index);
                        });
                      },
                      childWhenDragging: Container(),
                      feedback: Container(
                        width: 90.0,
                        height: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1.0, color: Colors.black45),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            data1[index],
                            style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ));
              }),
            ),
          ),
        ));
  }
}
