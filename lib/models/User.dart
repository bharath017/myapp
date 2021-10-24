import 'dart:convert';

class User {
  final String FirstName;
  final String LastName;
  final String Username;
  final String Password;

  User(
      {required this.FirstName,
      required this.LastName,
      required this.Username,
      required this.Password});

  Map<String, dynamic> toMap() {
    return {
      'FirstName': FirstName,
      'LastName': LastName,
      'Username': Username,
      'Password': Password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        Username: json['Username'] as String,
        FirstName: json['FirstName'] as String,
        LastName: json['LastName'] as String,
        Password: json['Password'] as String);
  }

  @override
  String toString() {
    return 'User(FirstName: $FirstName, LastName: $LastName, Username: $Username, Password: $Password)';
  }
}
