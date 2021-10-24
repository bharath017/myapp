class Lessons {
  int? topicId;
  int? ageId;
  int? lessonId;
  String? lessonTitle;
  int? childId;
  String? topicTitle;
  String? scorePercentage;
  dynamic achievement;
  int? noOfQuestions;
  int? correctAnswers;
  String? status;
  String? award;
  bool? lessonCompleted;
  int? lessonOrder;
  dynamic workBook;

  Lessons({
    this.topicId,
    this.ageId,
    this.lessonId,
    this.lessonTitle,
    this.childId,
    this.topicTitle,
    this.scorePercentage,
    this.achievement,
    this.noOfQuestions,
    this.correctAnswers,
    this.status,
    this.award,
    this.lessonCompleted,
    this.lessonOrder,
    this.workBook,
  });

  @override
  String toString() {
    return 'Lessons(topicId: $topicId, ageId: $ageId, lessonId: $lessonId, lessonTitle: $lessonTitle, childId: $childId, topicTitle: $topicTitle, scorePercentage: $scorePercentage, achievement: $achievement, noOfQuestions: $noOfQuestions, correctAnswers: $correctAnswers, status: $status, award: $award, lessonCompleted: $lessonCompleted, lessonOrder: $lessonOrder, workBook: $workBook)';
  }

  factory Lessons.fromJson(Map<String, dynamic> json) => Lessons(
        topicId: json['TopicId'] as int?,
        ageId: json['AgeId'] as int?,
        lessonId: json['LessonId'] as int?,
        lessonTitle: json['LessonTitle'] as String?,
        childId: json['ChildId'] as int?,
        topicTitle: json['TopicTitle'] as String?,
        scorePercentage: json['ScorePercentage'] as String?,
        achievement: json['Achievement'],
        noOfQuestions: json['NoOfQuestions'] as int?,
        correctAnswers: json['CorrectAnswers'] as int?,
        status: json['Status'] as String?,
        award: json['Award'] as String?,
        lessonCompleted: json['LessonCompleted'] as bool?,
        lessonOrder: json['LessonOrder'] as int?,
        workBook: json['WorkBook'],
      );

  Map<String, dynamic> toJson() => {
        'TopicId': topicId,
        'AgeId': ageId,
        'LessonId': lessonId,
        'LessonTitle': lessonTitle,
        'ChildId': childId,
        'TopicTitle': topicTitle,
        'ScorePercentage': scorePercentage,
        'Achievement': achievement,
        'NoOfQuestions': noOfQuestions,
        'CorrectAnswers': correctAnswers,
        'Status': status,
        'Award': award,
        'LessonCompleted': lessonCompleted,
        'LessonOrder': lessonOrder,
        'WorkBook': workBook,
      };
}
