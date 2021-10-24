import 'package:myapp/models/options.dart';

class MatchService {
  List<Options> options = [];
  List data1 = [];
  List data2 = [];
  generateArray(List<Options> opt) {
    options = opt;
    for (int i = 0; i < options.length; i++) {
      data1.add(options[i].answerOption!.split("=")[0]);
      data2.add(options[i].answerOption!.split("=")[1]);
    }
    data1.shuffle();
    data2.shuffle();
  }
}
