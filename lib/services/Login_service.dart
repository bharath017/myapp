import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:myapp/app_example/Welcome_Page.dart';
import 'package:myapp/evnironment/Api.dart';
import 'package:myapp/models/Child.dart';
import 'package:myapp/models/Login_Model.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/User_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  // static String apiUrl = "";

  SharedPreferences? preferences;

  ApiURL api = new ApiURL();

//final String apiUrl = api+'Users/Child/";
  Future<UserModel> login(loginmodel loginmodel, BuildContext context) async {
    Map data = {
      'Username': loginmodel.Username,
      'Password': loginmodel.Password
    };

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
      UserModel mod = UserModel.fromJson(jsonDecode(response.body));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => WelcomePage(mod.Id)));
      this.preferences = await SharedPreferences.getInstance();

      this.preferences?.setInt('UserId', mod.Id);
      this.preferences?.setString("Token", mod.Token.toString());
      this.preferences?.setBool("isLoggedIn", true);
      return mod;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to get User data');
      final snackBar = SnackBar(
        content: const Text('Username/Password is incorrect'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // return UserModel.fromJson(jsonDecode(response.body));
      throw Exception("Wrong username or password");
    }

    // final Response response = await post(
    //   apiUrl,
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(data),
    // );
    // if (response.statusCode == 200) {
    //   return loginmodel.fromJson(json.decode(response.body));
    // } else {
    //   throw Exception('Failed to post cases');
    // }
  }

  Future<List<Child>> getChildList(userId) async {
    String url = api.geturl + 'Users/Child/' + userId.toString();
    final res = await get(Uri.parse(url));

    if (res.statusCode == 200) {
      return compute(parsedata, res.body);
    } else {
      throw "Failed to load cases list";
    }
  }
}

List<Child> parsedata(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Child>((json) => Child.fromJson(json)).toList();
}
