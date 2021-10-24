class user2 {
  final int Id;
  final String FirstName;
  final String LastName;
  final String Username;
  final String Token;
  final String Password;

  user2(
      {required this.Id,
      required this.FirstName,
      required this.LastName,
      required this.Username,
      required this.Token,
      required this.Password});

  static fromJson(Map<String, dynamic> json) {
    return user2(
        Username: json['Username'] as String,
        FirstName: json['FirstName'] as String,
        LastName: json['LastName'] as String,
        Token: json['Token'] as String,
        Id: json['Id'] as int,
        Password: json['Password'] as String);
  }

  @override
  String toString() {
    return 'user2{Username: $Username, FirstName: $FirstName, LastName: $LastName, Token: $Token, Id: $Id,Password: $Password}';
  }
}
