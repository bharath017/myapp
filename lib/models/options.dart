class Options {
  int? answerOptionId;
  String? answerOption;
  bool? isCorrect;

  Options({this.answerOptionId, this.answerOption, this.isCorrect});

  @override
  String toString() {
    return 'Options(answerOptionId: $answerOptionId, answerOption: $answerOption, isCorrect: $isCorrect)';
  }

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        answerOptionId: json['AnswerOptionId'] as int?,
        answerOption: json['AnswerOption'] as String?,
        isCorrect: json['IsCorrect'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'AnswerOptionId': answerOptionId,
        'AnswerOption': answerOption,
        'IsCorrect': isCorrect,
      };

  Options copyWith({
    int? answerOptionId,
    String? answerOption,
    bool? isCorrect,
  }) {
    return Options(
      answerOptionId: answerOptionId ?? this.answerOptionId,
      answerOption: answerOption ?? this.answerOption,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}
