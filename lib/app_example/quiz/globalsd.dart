import 'package:flutter/cupertino.dart';

class globalsd {
  Offset squarePos = Offset(1, 0.5);
  Offset tapPos = Offset(0, 0);
  globalsd() {
    tapPos = this.squarePos;
  }
  bool ghost = false;
  bool repaint = false;
}
