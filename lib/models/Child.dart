class Child {
  final int AgeId;
  final int ChildId;
  final String ChildName;
  final String ChildType;
  final int ClassId;
  final int CurrentTopic;
  final String FirstName;
  final int MasteryQuizes;
  final String Password;
  final int UserId;

  Child(
      {required this.AgeId,
      required this.ChildId,
      required this.ChildName,
      required this.ChildType,
      required this.ClassId,
      required this.CurrentTopic,
      required this.FirstName,
      required this.MasteryQuizes,
      required this.Password,
      required this.UserId});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
        ChildName: json['ChildName'] as String,
        FirstName: json['FirstName'] as String,
        UserId: json['UserId'] as int,
        ChildId: json['ChildId'] as int,
        ClassId: json['ClassId'] as int,
        CurrentTopic: json['CurrentTopic'] as int,
        AgeId: json['AgeId'] as int,
        MasteryQuizes: json['MasteryQuizes'] as int,
        Password: json['Password'] as String,
        ChildType: json['ChildType'] as String);
  }

  @override
  String toString() {
    return 'Child{ChildName: $ChildName, ChildType: $ChildType , FirstName: $FirstName, UserId: $UserId, ChildId: $ChildId, ClassId: $ClassId, CurrentTopic: $CurrentTopic, AgeId: $AgeId, MasteryQuizes: $MasteryQuizes, Password: $Password}';
  }
}
