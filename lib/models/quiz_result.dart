class QuizResult {
  int? id;
  int? childId;
  int? lessonId;
  String? scorePercentage;
  String? achievement;
  int? noOfQuestions;
  int? correctAnswers;
  String? status;
  int? topicId;
  bool? lessonCompleted;
  String? award;

  QuizResult({
    this.id,
    this.childId,
    this.lessonId,
    this.scorePercentage,
    this.achievement,
    this.noOfQuestions,
    this.correctAnswers,
    this.status,
    this.topicId,
    this.lessonCompleted,
    this.award,
  });

  @override
  String toString() {
    return 'QuizResult(id: $id, childId: $childId, lessonId: $lessonId, scorePercentage: $scorePercentage, achievement: $achievement, noOfQuestions: $noOfQuestions, correctAnswers: $correctAnswers, status: $status, topicId: $topicId, lessonCompleted: $lessonCompleted, award: $award)';
  }

  factory QuizResult.fromJson(Map<String, dynamic> json) => QuizResult(
        id: json['ID'] as int?,
        childId: json['ChildId'] as int?,
        lessonId: json['LessonId'] as int?,
        scorePercentage: json['ScorePercentage'] as String?,
        achievement: json['Achievement'] as String?,
        noOfQuestions: json['NoOfQuestions'] as int?,
        correctAnswers: json['CorrectAnswers'] as int?,
        status: json['Status'] as String?,
        topicId: json['TopicId'] as int?,
        lessonCompleted: json['LessonCompleted'] as bool?,
        award: json['Award'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'ChildId': childId,
        'LessonId': lessonId,
        'ScorePercentage': scorePercentage,
        'Achievement': achievement,
        'NoOfQuestions': noOfQuestions,
        'CorrectAnswers': correctAnswers,
        'Status': status,
        'TopicId': topicId,
        'LessonCompleted': lessonCompleted,
        'Award': award,
      };

  QuizResult copyWith({
    int? id,
    int? childId,
    int? lessonId,
    String? scorePercentage,
    String? achievement,
    int? noOfQuestions,
    int? correctAnswers,
    String? status,
    int? topicId,
    bool? lessonCompleted,
    String? award,
  }) {
    return QuizResult(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      lessonId: lessonId ?? this.lessonId,
      scorePercentage: scorePercentage ?? this.scorePercentage,
      achievement: achievement ?? this.achievement,
      noOfQuestions: noOfQuestions ?? this.noOfQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      status: status ?? this.status,
      topicId: topicId ?? this.topicId,
      lessonCompleted: lessonCompleted ?? this.lessonCompleted,
      award: award ?? this.award,
    );
  }
}
