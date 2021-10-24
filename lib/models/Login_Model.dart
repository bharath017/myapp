import 'dart:convert';

class loginmodel {
  final String Username;
  final String Password;

  loginmodel({required this.Username, required this.Password});

  fromJson(Map<String, dynamic> json) {
    return loginmodel(
        Username: json['Username'] as String,
        Password: json['password'] as String);
  }

  @override
  String toString() {
    return 'loginmodel{Username: $Username, Password: $Password}';
  }
}
