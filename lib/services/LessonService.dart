import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/app_example/quiz/QuizResult.dart';
import 'package:myapp/evnironment/Api.dart';
import 'package:myapp/models/Child.dart';
import 'package:myapp/models/current_lesson.dart';
import 'package:myapp/models/current_topic_lessons.dart';
import 'package:myapp/models/lesson_model.dart';
import 'package:myapp/models/quiz_model.dart';
import 'package:myapp/models/quiz_result.dart';
import 'package:myapp/models/submit_quiz.dart';

class LessonService {
  //final String apiUrl = "https://localhost:5001/Users/ChildData/";
  ApiURL api = new ApiURL();
  Future<LessonModel> getLesson(int lessonId) async {
    final response = await http.get(
      Uri.parse(api.geturl + 'Lesson/' + lessonId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return LessonModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<QuizModel> getQuizQuestions(int lessonId) async {
    final response = await http.get(
      Uri.parse(api.geturl + 'Quiz/' + lessonId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return QuizModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  void submitQuiz(SubmitQuiz submitQuiz, BuildContext context) async {
    print(jsonEncode(submitQuiz));
    final response =
        await http.patch(Uri.parse(api.geturl + 'Lesson/ChildLesson/Quiz'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(submitQuiz));
    if (response.statusCode == 200) {
      print(response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizResultScreen(
                  QuizResult.fromJson(jsonDecode(response.body)))));
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}


// {"ID":2,"ChildId":3,"LessonId":13,"ScorePercentage":"150","Achievement":null,"NoOfQuestions":8,"CorrectAnswers":6,"Status":"completed","TopicId":1,"LessonCompleted":true,"Award":"No Medal"}