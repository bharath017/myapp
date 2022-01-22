import 'dart:io' show Platform;

class ApiURL {
  // static String url = "https://localhost:5001/";

  String get geturl {
    if (Platform.isAndroid) {
      return "http://192.168.0.101:5000/";
      // return "https://10.0.2.2:5001/";
    } else {
      return "http://192.168.0.101:5000/";
      //return "https://localhost:5001/";
    }
  }
}
