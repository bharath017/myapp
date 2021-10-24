import 'package:flutter/material.dart';
import 'package:myapp/app_example/quiz/globalsd.dart';
import 'globals.dart' as globals;
import 'package:draw_arrow/draw_arrow.dart';

//import 'globals.dart';

class MyApp34 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage223(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage223 extends StatefulWidget {
  MyHomePage223({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage223> {
  final formKey = GlobalKey<FormState>();
  List<globalsd> gl = [globalsd(), globalsd(), globalsd(), globalsd()];
  double sideLength = 50;
  int acceptedData = 0;
  //_MyHomePageState(this.gl=new );
  bool amIHovering = false;
  Offset exitFrom = Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      child: Container(
        height: 400,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                  4,
                  (index) => Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, style: BorderStyle.solid)),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      // behavior: HitTestBehavior.translucent,
                      onPanStart: (details) {
                        gl[index].ghost = true;
                      },
                      onPanUpdate: (details) {
                        // print("Global gesture=" +
                        //     details.globalPosition.toString());
                        // print("Local gesture=" +
                        //     details.localPosition.toString());

                        setState(() {
                          gl[index].tapPos = details.localPosition;
                          gl[index].repaint = true;
                        });
                      },
                      onPanEnd: (details) {
                        // print(gl[index].tapPos);
                        setState(() {
                          gl[index].ghost = true;
                          gl[index].repaint = false;
                        });
                      },

                      child: CustomPaint(
                        painter: UIPainter(gl[index]),
                        size: Size.infinite,
                        child: Container(),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            Column(children: [
              Wrap(
                direction: Axis.vertical, spacing: 8.0, runSpacing: 4.0,
                //padding: const EdgeInsets.all(8),
                children: List.generate(
                  4,
                  (index) => DragTarget<int>(
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return Container(
                        height: 80.0,
                        width: 80.0,
                        color: Colors.cyan,
                        child: Center(
                          child: Text('Value is updated to: $acceptedData'),
                        ),
                      );
                    },
                    onAccept: (int data) {
                      print(data);
                      setState(() {
                        acceptedData += data;
                      });
                    },
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    )));
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
