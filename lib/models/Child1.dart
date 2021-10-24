import 'dart:convert';

class Child1 {
  int AgeId;
  String FirstName;

  Child1({
    required this.AgeId,
    required this.FirstName,
  });

  @override
  String toString() => 'Child1(AgeId: $AgeId, FirstName: $FirstName)';

  factory Child1.fromJson(Map<String, dynamic> json) {
    return Child1(
        FirstName: json['ChildName'] as String, AgeId: json['AgeId'] as int);
  }

  Map<String, dynamic> toMap() {
    return {
      'AgeId': AgeId,
      'FirstName': FirstName,
    };
  }

  Child1 getById(dynamic id) => Child1(AgeId: 0, FirstName: '');

  Child1 getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }

  // factory Child1.fromMap(Map<String, dynamic> map) {
  //   return Child1(
  //     AgeId: map['AgeId'],
  //     ChildName: map['ChildName'],
  //   );
  // }

  String toJson() => json.encode(toMap());
}
