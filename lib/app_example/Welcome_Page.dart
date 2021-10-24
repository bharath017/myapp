import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/Child.dart';
import 'package:myapp/models/User_Model.dart';
import 'package:myapp/services/Login_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ChildHome.dart';
import 'Login_Screen.dart';

class WelcomePage extends StatelessWidget {
  final int? Id;
  final LoginService api = LoginService();

  WelcomePage(this.Id);

  @override
  Widget build(BuildContext context) {
    //  Map<String, dynamic> user = jsonDecode(value);
    // var id = Id;
    //var token = value.Token;

    List<Child> children;
    String childName;
    int AgeId;
    // Future<List<Child>> children = api.getChildList(userId, token);
    //children.forEach((element) {});
    var _screenHeight = MediaQuery.of(context).size.height;
    return new Scaffold(
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Color(0x44000000),
          title: new Text("Home Page"),
        ), // appBar
        body: Container(
            height: _screenHeight / 1.2,
            child: Column(children: [
              FutureBuilder<List<Child>>(
                future: api.getChildList(Id),
                builder: (context, snapshot) {
                  print(snapshot);
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? ChildrenList(children: snapshot.data!)
                      : Center(child: CircularProgressIndicator());
                },
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: MaterialButton(
                    onPressed: () => {},
                    color: Colors.blue.shade200,
                    child: TextButton(
                        onPressed: () {
                          launch(
                              'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                        },
                        child: Text(
                          'Login as parent',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ),
            ])));
  }
}

class ChildrenList extends StatefulWidget {
  final List<Child> children;

  ChildrenList({Key? key, required this.children}) : super(key: key);
  @override
  State<ChildrenList> createState() => _ChildrenListState(children);
}

class _ChildrenListState extends State<ChildrenList> {
  final List<Child> children;
  _ChildrenListState(this.children);
  @override
  void initState() {
    initiate();
    super.initState();
  }

  late SharedPreferences logindata;
  void initiate() async {
    logindata = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(
            _screenWidth > 500 ? 200 : _screenWidth * 0.05,
            80,
            _screenWidth > 500 ? 200 : _screenWidth * 0.05,
            30),
        itemCount: children.length == 0 ? 0 : children.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: InkWell(
            onTap: () {
              logindata.setInt("ChildId", children[index].ChildId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChildHome(children[index].ChildId),
                ),
              );
            },
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(children[index].FirstName),
              subtitle: Text(children[index].AgeId.toString()),
            ),
          ));
        });
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
