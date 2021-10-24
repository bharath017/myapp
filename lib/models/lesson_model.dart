class LessonModel {
  final int? lessonId;
  final String? content;
  final String? lessonTitle;
  final int? topicId;
  final int? lessonOrder;
  final String? imageUrl;
  final dynamic workBook;

  const LessonModel({
    this.lessonId,
    this.content,
    this.lessonTitle,
    this.topicId,
    this.lessonOrder,
    this.imageUrl,
    this.workBook,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
        lessonId: json['LessonId'] as int?,
        content: json['Content'] as String?,
        lessonTitle: json['LessonTitle'] as String?,
        topicId: json['TopicId'] as int?,
        lessonOrder: json['LessonOrder'] as int?,
        imageUrl: json['ImageUrl'] as String?,
        workBook: json['WorkBook'],
      );

  Map<String, dynamic> toJson() => {
        'LessonId': lessonId,
        'Content': content,
        'LessonTitle': lessonTitle,
        'TopicId': topicId,
        'LessonOrder': lessonOrder,
        'ImageUrl': imageUrl,
        'WorkBook': workBook,
      };

  LessonModel copyWith({
    int? lessonId,
    String? content,
    String? lessonTitle,
    int? topicId,
    int? lessonOrder,
    String? imageUrl,
    dynamic workBook,
  }) {
    return LessonModel(
      lessonId: lessonId ?? this.lessonId,
      content: content ?? this.content,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      topicId: topicId ?? this.topicId,
      lessonOrder: lessonOrder ?? this.lessonOrder,
      imageUrl: imageUrl ?? this.imageUrl,
      workBook: workBook ?? this.workBook,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      lessonId,
      content,
      lessonTitle,
      topicId,
      lessonOrder,
      imageUrl,
      workBook,
    ];
  }
}
