import 'current_topic_lessons.dart';

class CurrentLesson {
  List<Lessons>? CurrentTopicLessons;

  CurrentLesson({this.CurrentTopicLessons});

  @override
  String toString() {
    return 'CurrentLesson(currentTopicLessons: $CurrentTopicLessons)';
  }

  factory CurrentLesson.fromJson(Map<String, dynamic> json) => CurrentLesson(
        CurrentTopicLessons: (json['Lessons'] as List<dynamic>?)
            ?.map((e) => Lessons.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'Lessons': CurrentTopicLessons?.map((e) => e.toJson()).toList(),
      };
}
