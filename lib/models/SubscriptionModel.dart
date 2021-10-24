import 'Child1.dart';

class SubscriptionModel {
  int PlanId;
  int UserId;
  List<Child1> Children;

  SubscriptionModel({
    required this.PlanId,
    required this.UserId,
    required this.Children,
  });
}

/*

import 'Child1.dart';

class SubscriptionModel {
  int PlanId;
  int UserId;
  String StartDate;
  String EndDate;
  String SubscriptionDate;
  List<Childrenn> Children;

  SubscriptionModel(
      {required this.PlanId,
      required this.UserId,
      required this.StartDate,
      required this.EndDate,
      required this.SubscriptionDate,
      required this.Children});

  // SubscriptionModel.fromJson(Map<String, dynamic> json) {
  //   PlanId = json['PlanId'];
  //   UserId = json['UserId'];
  //   StartDate = json['StartDate'];
  //   EndDate = json['EndDate'];
  //   SubscriptionDate = json['SubscriptionDate'];
  //   if (json['Children'] != null) {
  //     // Children = new List<Children>();
  //     json['Children'].forEach((v) {
  //       Children.add(new Childrenn.fromJson(v));
  //     });
  //   }
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PlanId'] = this.PlanId;
    data['UserId'] = this.UserId;
    data['StartDate'] = this.StartDate;
    data['EndDate'] = this.EndDate;
    data['SubscriptionDate'] = this.SubscriptionDate;
    if (this.Children != null) {
      data['Children'] = this.Children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Childrenn {
  int AgeId;
  String FirstName;
  String LastName;
  int UserId;
  String ChildName;
  int ChildId;
  String ChildType;
  int ClassId;

  Childrenn(
      {required this.AgeId,
      required this.FirstName,
      required this.LastName,
      required this.UserId,
      required this.ChildName,
      required this.ChildId,
      required this.ChildType,
      required this.ClassId});

  // Childrenn.fromJson(Map<String, dynamic> json) {
  //   AgeId = json['AgeId'];
  //   FirstName = json['FirstName'];
  //   LastName = json['LastName'];
  //   UserId = json['UserId'];
  //   ChildName = json['ChildName'];
  //   ChildId = json['ChildId'];
  //   ChildType = json['ChildType'];
  //   ClassId = json['ClassId'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AgeId'] = this.AgeId;
    data['FirstName'] = this.FirstName;
    data['LastName'] = this.LastName;
    data['UserId'] = this.UserId;
    data['ChildName'] = this.ChildName;
    data['ChildId'] = this.ChildId;
    data['ChildType'] = this.ChildType;
    data['ClassId'] = this.ClassId;
    return data;
  }
}


 */
