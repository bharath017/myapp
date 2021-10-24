class UserModel {
  final int Id;
  final String? FirstName;
  final String? LastName;
  final String? Username;
  final String? Token;

  UserModel(
      {required this.Id,
      required this.FirstName,
      required this.LastName,
      required this.Username,
      required this.Token});

  static fromJson(Map<String, dynamic>? json) {
    return UserModel(
        Username: json!['Username'] as String,
        FirstName: json['FirstName'] as String,
        LastName: json['LastName'] as String,
        Token: json['Token'] as String,
        Id: json['Id'] as int);
  }

  @override
  String toString() {
    return 'UserModel{Username: $Username, FirstName: $FirstName, LastName: $LastName, Token: $Token, Id: $Id}';
  }
}
