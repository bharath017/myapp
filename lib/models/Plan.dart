import 'dart:convert';

class Plan {
  final int PlanId;
  final String PlanType;
  final String NoOfChildren;

  Plan(
      {required this.PlanId,
      required this.PlanType,
      required this.NoOfChildren});

  Map<String, dynamic> toMap() {
    return {
      'PlanId': PlanId,
      'PlanType': PlanType,
      'NoOfChildren': NoOfChildren,
    };
  }

  static fromJson(Map<String, dynamic> json) {
    return Plan(
        PlanId: json['PlanId'] as int,
        PlanType: json['PlanType'] as String,
        NoOfChildren: json['NoOfChildren'] as String);
  }

  @override
  String toString() =>
      'Plan(PlanId: $PlanId, PlanType: $PlanType, NoOfChildren: $NoOfChildren)';
}
