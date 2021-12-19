import 'options.dart';

class Quiz {
  int? questionId;
  String? question;
  dynamic imageUrl;
  int? questionType;
  List<Options>? options;

  Quiz({
    this.questionId,
    this.question,
    this.imageUrl,
    this.questionType,
    this.options,
  });

  @override
  String toString() {
    return 'Quiz(questionId: $questionId, question: $question, imageUrl: $imageUrl, questionType: $questionType, options: $options)';
  }

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        questionId: json['QuestionId'] as int?,
        question: json['Questions'] as String?,
        imageUrl: json['ImageUrl'],
        questionType: json['QuestionType'] as int?,
        options: (json['Options'] as List<dynamic>?)
            ?.map((e) => Options.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'QuestionId': questionId,
        'Questions': question,
        'ImageUrl': imageUrl,
        'QuestionType': questionType,
        'Options': options?.map((e) => e.toJson()).toList(),
      };

  Quiz copyWith({
    int? questionId,
    String? question,
    dynamic imageUrl,
    int? questionType,
    List<Options>? options,
  }) {
    return Quiz(
      questionId: questionId ?? this.questionId,
      question: question ?? this.question,
      imageUrl: imageUrl ?? this.imageUrl,
      questionType: questionType ?? this.questionType,
      options: options ?? this.options,
    );
  }
}
