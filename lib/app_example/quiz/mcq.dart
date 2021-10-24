import 'package:flutter/material.dart';
import 'package:myapp/models/options.dart';

import '../Quiz.dart';

class mcq extends StatefulWidget {
  late List<Options> options;

  mcq({Key? key, required this.options}) : super(key: key) {}

  @override
  _MCQState createState() => new _MCQState();

  static getsubanswer() {
    return _MCQState.getanswer();
  }
}

class _MCQState extends State<mcq> {
  // _State(this.options);
  void initState() {
    super.initState();
  }

  // static Options answeroption = Options();
  String image = "https://localhost:5001/src/images/";
  @override
  Widget build(BuildContext context) {
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 80;
    var _aspectRatio = _width / cellHeight;

    //print(widget.options);
    return Container(
      child: Container(
          child: GridView.count(
        padding: EdgeInsets.fromLTRB(
            _screenWidth * 0.08, 10, _screenWidth * 0.08, 10),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        shrinkWrap: true,
        childAspectRatio: _aspectRatio,
        children: widget.options
            .map((data) => Container(
                decoration: BoxDecoration(
                    color: data.answerOptionId == id
                        ? Colors.lime[200]
                        : Colors.blue[50],
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: RadioListTile(
                  activeColor: Colors.lime,
                  selectedTileColor: Colors.blue[100],
                  contentPadding: EdgeInsets.all(10.0),
                  title: Text(
                    "${data.answerOption}",
                    textAlign: TextAlign.left,
                  ),
                  groupValue: id,
                  value: data.answerOptionId!,
                  onChanged: (val) {
                    setState(() {
                      radioItemHolder = data.answerOption!;
                      id = data.answerOptionId!;
                      // answeroption = data;
                    });
                  },
                )))
            .toList(),
      )),
    );
  }

  static getanswer() {
    return id;
  }
}
