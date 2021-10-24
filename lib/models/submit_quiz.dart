import 'quiz_answers.dart';

class SubmitQuiz {
  int? childId;
  int? lessonId;
  String? quizType;
  List<QuizAnswers>? quizAnswers;

  SubmitQuiz({
    this.childId,
    this.lessonId,
    this.quizType,
    this.quizAnswers,
  });

  @override
  String toString() {
    return 'SubmitQuiz(childId: $childId, lessonId: $lessonId, quizType: $quizType, quizAnswers: $quizAnswers)';
  }

  factory SubmitQuiz.fromJson(Map<String, dynamic> json) => SubmitQuiz(
        childId: json['ChildId'] as int?,
        lessonId: json['LessonId'] as int?,
        quizType: json['QuizType'] as String?,
        quizAnswers: (json['QuizAnswers'] as List<dynamic>?)
            ?.map((e) => QuizAnswers.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'ChildId': childId,
        'LessonId': lessonId,
        'QuizType': quizType,
        'QuizAnswers': quizAnswers?.map((e) => e.toJson()).toList(),
      };

  SubmitQuiz copyWith({
    int? childId,
    int? lessonId,
    String? quizType,
    List<QuizAnswers>? quizAnswers,
  }) {
    return SubmitQuiz(
      childId: childId ?? this.childId,
      lessonId: lessonId ?? this.lessonId,
      quizType: quizType ?? this.quizType,
      quizAnswers: quizAnswers ?? this.quizAnswers,
    );
  }
}
