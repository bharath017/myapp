import 'dart:convert';

class user1 {
  final int Id;
  final String? FirstName;
  final String? LastName;
  final String? Username;

  user1(
      {required this.Id,
      required this.FirstName,
      required this.LastName,
      required this.Username});

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'FirstName': FirstName,
      'LastName': LastName,
      'Username': Username,
    };
  }

  static fromJson(Map<String, dynamic>? json) {
    return user1(
        Username: json!['Username'] as String,
        FirstName: json['FirstName'] as String,
        LastName: json['LastName'] as String,
        Id: json['Id'] as int);
  }

  String toJson() => json.encode(toMap());
}
