import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/app_example/Subscription_Page.dart';
import 'package:myapp/app_example/Welcome_Page.dart';
import 'package:myapp/evnironment/Api.dart';

import 'package:myapp/models/SubscriptionModel.dart';
import 'package:myapp/models/User.dart';
import 'package:myapp/models/User_Model.dart';
import 'package:myapp/models/user1.dart';
import 'package:myapp/models/user2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpService {
  SharedPreferences? preferences;
  // static String apiUrl = "";
//  final String apiUrl = "https://localhost:5001/Users/";
  ApiURL api = new ApiURL();
  Future<UserModel> login(user2 usermodel, BuildContext context) async {
    Map data = {
      'Username': usermodel.Username,
      'FirstName': usermodel.FirstName,
      'LastName': usermodel.LastName,
      'Password': usermodel.Password
    };
    print(data);
    final response = await http.post(
      Uri.parse(api.geturl + 'Users/authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  WelcomePage(UserModel.fromJson(jsonDecode(response.body)))));
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  signup(User user, BuildContext context) async {
    Map data = {
      'Username': user.Username,
      'FirstName': user.FirstName,
      'LastName': user.LastName,
      'Password': user.Password
    };
    print(jsonEncode(data));
    final response = await http.post(
      Uri.parse(api.geturl + 'Users/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Subscription(user1.fromJson(jsonDecode(response.body)))));
      return user1.fromJson(jsonDecode(response.body));
    } else {
      final snackBar = SnackBar(
        content: const Text('Username/Email is already taken'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw Exception('Failed to load album');
    }
  }

  void Subscribe(SubscriptionModel formdata, BuildContext context) async {
    final jsonEncoder = JsonEncoder();
    Map data = {
      'UserId': formdata.UserId,
      'PlanId': formdata.PlanId,
      'Children': formdata.Children,
    };

    String fixable = jsonEncode(data);
    fixable = fixable.replaceAll(r'\"', '"');
    fixable = fixable.replaceAll('"{', '{');
    fixable = fixable.replaceAll('}"', '}');

    final response = await http.post(
      Uri.parse(api.geturl + 'Subscription/Subscribe'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: fixable,
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      UserModel mod = UserModel.fromJson(jsonDecode(response.body));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => WelcomePage(mod.Id)));
      this.preferences = await SharedPreferences.getInstance();

      this.preferences?.setInt('UserId', mod.Id);
      this.preferences?.setString("Token", mod.Token.toString());
      this.preferences?.setBool("isLoggedIn", true);
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get User data');
    }
  }
}
