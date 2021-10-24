import 'package:flutter/material.dart';

class Boxes extends StatelessWidget {
  const Boxes({Key? key}) : super(key: key);

  @override
  build(_) => MaterialApp(
          home: Scaffold(
              body: SafeArea(
                  child: Stack(children: <Widget>[
        const Lines(),
      ]))));
}

class Lines extends StatefulWidget {
  const Lines({Key? key}) : super(key: key);

  @override
  createState() => _LinesState();
}

class _LinesState extends State<Lines> {
  late Offset start;
  late Offset end;

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  build(_) => GestureDetector(
        onTap: () => print('t'),
        onPanStart: (details) {
          print(details.localPosition);
          setState(() {
            end = details.localPosition;
            start = Offset.zero;
          });
        },
        onPanUpdate: (details) {
          setState(() {
            end = details.localPosition;
          });
        },
        child: CustomPaint(
          size: Size.infinite,
          //painter: LinesPainter(start, end),
          child: IgnorePointer(
              child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 45,
            crossAxisSpacing: 25,
            padding: const EdgeInsets.all(25),
            children: <Widget>[
              for (int i = 0; i < 6; i++)
                Container(
                  color: const Color(0xffe4f2fd),
                  foregroundDecoration: BoxDecoration(
                      border: Border.all(
                    color: const Color(0xffc2d2e1),
                    width: 2,
                  )),
                  child: const Center(
                    child: Text('MyBox'),
                  ),
                )
            ],
          )),
        ),
      );
}

class LinesPainter extends CustomPainter {
  final Offset start, end;

  LinesPainter(this.start, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    if (start == null || end == null) return;
    print(start);
    print(end);
    canvas.drawLine(
        start,
        end,
        Paint()
          ..strokeWidth = 4
          ..color = Colors.redAccent);
  }

  @override
  bool shouldRepaint(LinesPainter oldDelegate) {
    return true;
    //return oldDelegate.start != start || oldDelegate.end != end;
  }
}
