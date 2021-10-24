class QuizAnswers {
  int? questionId;
  int? answerId;
  String? answerOption;
  int? questionType;

  QuizAnswers({
    this.questionId,
    this.answerId,
    this.answerOption,
    this.questionType,
  });

  @override
  String toString() {
    return 'QuizAnswers(questionId: $questionId, answerId: $answerId, answerOption: $answerOption, questionType: $questionType)';
  }

  factory QuizAnswers.fromJson(Map<String, dynamic> json) => QuizAnswers(
        questionId: json['QuestionId'] as int?,
        answerId: json['AnswerId'] as int?,
        answerOption: json['AnswerOption'] as String?,
        questionType: json['QuestionType'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'QuestionId': questionId,
        'AnswerId': answerId,
        'AnswerOption': answerOption,
        'QuestionType': questionType,
      };

  QuizAnswers copyWith({
    int? questionId,
    int? answerId,
    String? answerOption,
    int? questionType,
  }) {
    return QuizAnswers(
      questionId: questionId ?? this.questionId,
      answerId: answerId ?? this.answerId,
      answerOption: answerOption ?? this.answerOption,
      questionType: questionType ?? this.questionType,
    );
  }
}
