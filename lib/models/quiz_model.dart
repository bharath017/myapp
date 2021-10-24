import 'quiz.dart';

class QuizModel {
  int? lessonId;
  List<Quiz>? quiz;

  QuizModel({this.lessonId, this.quiz});

  @override
  String toString() => 'QuizModel(lessonId: $lessonId, quiz: $quiz)';

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        lessonId: json['lessonId'] as int?,
        quiz: (json['Quiz'] as List<dynamic>?)
            ?.map((e) => Quiz.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'lessonId': lessonId,
        'Quiz': quiz?.map((e) => e.toJson()).toList(),
      };

  QuizModel copyWith({
    int? lessonId,
    List<Quiz>? quiz,
  }) {
    return QuizModel(
      lessonId: lessonId ?? this.lessonId,
      quiz: quiz ?? this.quiz,
    );
  }
}
