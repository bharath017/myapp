import 'dart:io' show Platform;

class ApiURL {
  // static String url = "https://localhost:5001/";

  String get geturl {
    if (Platform.isAndroid) {
      return "https://192.168.0.105:5001/";
      // return "https://10.0.2.2:5001/";
    } else {
      return "https://192.168.0.105:5001/";
      //return "https://localhost:5001/";
    }
  }
}
