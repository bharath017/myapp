import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:myapp/evnironment/Api.dart';
import 'package:myapp/models/Child.dart';
import 'package:myapp/models/current_lesson.dart';
import 'package:myapp/models/current_topic_lessons.dart';

class ChildrenService {
  // final String apiUrl = "https://10.0.2.2:5001/Users/ChildData/";
  ApiURL api = new ApiURL();
  Future<Child> getChildData(ChildId) async {
    String url = api.geturl + 'Users/ChildData' + ChildId.toString();
    final res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      return Child.fromJson(jsonDecode(res.body));
    } else {
      throw "Failed to get Child Data";
    }
  }

  //final String apiUrl1 = "https://10.0.2.2:5001/Lesson/Child/";
  Future<CurrentLesson> getCurrentLesson(int ChildId) async {
    CurrentLesson lesson = new CurrentLesson();
    String url = api.geturl + 'Lesson/Child/' + ChildId.toString();
    final res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      return compute(parsedata, res.body);
    } else {
      throw "Failed to get Lessons";
    }
  }

  CurrentLesson parsedata(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    print(parsed);
    return parsed.map<Lessons>((json) => Lessons.fromJson(json)).toList();
  }
}
