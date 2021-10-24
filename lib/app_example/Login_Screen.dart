import 'package:flutter/material.dart';
import 'package:myapp/app_example/Sign_Up.dart';
import 'package:myapp/models/Login_Model.dart';
import 'package:myapp/services/Login_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final LoginService api = LoginService();

  final cun = "bharath@gmail.com";
  final cp = "12345";
  String errorText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),
          elevation: 0,
          backgroundColor: Color(0x44000000),
        ),
        body: SafeArea(
            child: Container(
                alignment: Alignment.center,
                child: Form(
                    key: formKey,
                    child: Container(
                        width: 400,
                        alignment: Alignment.center,
                        child: ListView(shrinkWrap: false, children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(10, 50, 10, 30),
                              child: Text(
                                'Login to learntoUnLock',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30),
                              )),
                          Container(child: Text(errorText)),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Username/Email address',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              )),
                          Container(
                            width: 200,
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              expands: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Username/Email address';
                                }
                                return null;
                              },
                              controller: nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Enter Username/Email address',
                              ),
                              obscureText: false,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  //formKey.currentState!.validate();
                                }
                                return null;
                                // formKey.currentState!.validate();
                                //   userName = value;
                                //formData.password = value;
                              },
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Password',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              )),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Password';
                                }
                                return null;
                              },
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Enter Password',
                              ),
                              obscureText: true,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  // formKey.currentState!.validate();
                                }
                                return null;
                                // formKey.currentState!.validate();
                                //    password = value;
                                //formData.password = value;
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              //forgot password screen
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            child: Text('Forgot Password'),
                          ),
                          Container(
                              height: 50,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ElevatedButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                child: Text('Login',
                                    style: TextStyle(fontSize: 25)),
                                onPressed: () {
                                  formKey.currentState!.save();
                                  if (formKey.currentState!.validate()) {
                                    final res = api.login(
                                        loginmodel(
                                            Username: nameController.text,
                                            Password: passwordController.text),
                                        context);

                                    print(res);
                                  }
                                },
                              )),
                          Container(
                              child: Row(
                            children: <Widget>[
                              Text('Do not have account?'),
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.blue,
                                ),
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(fontSize: 15),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ))
                        ]))))));
  }

  bool checkPassword(userName, password) {
    return cun == userName && cp == password;
  }
}
