import 'dart:convert';

class AgeGroup {
  final int AgeId;
  final String AgeRange;
  final int Age;

  AgeGroup({required this.AgeId, required this.AgeRange, required this.Age});

  Map<String, dynamic> toMap() {
    return {
      'AgeId': AgeId,
      'AgeRange': AgeRange,
      'Age': Age,
    };
  }

  static fromJson(Map<String, dynamic> json) {
    return AgeGroup(
        Age: json['Age'] as int,
        AgeRange: json['AgeRange'] as String,
        AgeId: json['AgeId'] as int);
  }

  @override
  String toString() =>
      'AgeGroup(AgeId: $AgeId, AgeRange: $AgeRange, Age: $Age)';
}
