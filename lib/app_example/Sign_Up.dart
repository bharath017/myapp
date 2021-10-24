import 'package:flutter/material.dart';
import 'package:myapp/app_example/Subscription_Page.dart';
import 'package:myapp/models/User.dart';
import 'package:myapp/models/User_Model.dart';
import 'package:myapp/services/SignUpService.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SignUp> {
  TextEditingController FirstNameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();
  TextEditingController UserNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SignUpService api = SignUpService();
  var userName;
  var password;
  String _passwordError = '';
  final cun = "bharath@gmail.com";
  final cp = "12345";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          elevation: 0,
          backgroundColor: Color(0x44000000),
        ),
        body: Container(
            alignment: Alignment.center,
            child: Form(
                key: formKey,
                child: Container(
                    width: 400,
                    child: ListView(children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(10, 40, 10, 30),
                          child: Text(
                            'Sign Up to learntoUnLock',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'First Name',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter First Name';
                            }
                            return null;
                          },
                          controller: FirstNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Enter First Name',
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.all(14),
                          ),
                          obscureText: false,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              // formKey.currentState!.validate();
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Last Name',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: LastNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Enter Last Name',
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.all(14),
                          ),
                          obscureText: false,
                          onChanged: (value) {
                            userName = value;
                            //formData.password = value;
                          },
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Mail Id',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter User Name/ Mail Id';
                            }
                            return null;
                          },
                          controller: UserNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Enter Mail Id',
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.all(14),
                          ),
                          obscureText: false,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              // formKey.currentState!.validate();
                            }
                            return null;
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
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: TextFormField(
                          validator: (value) {
                            print("calling");
                            if (!validateStructure(passwordController.text)) {
                              setState(() {
                                _passwordError =
                                    "Password Must contain a Upper case, Lower case, number and a symbol";
                              });
                              // show dialog/snackbar to get user attention.
                              return "Password Must contain a Upper case, Lower case, number and a symbol";
                            }
                          },
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Enter Password',
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.all(14),
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              //  formKey.currentState!.validate();
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Confirm Password',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password Again';
                            } else {
                              if (checkPassword(passwordController.text,
                                  confirmpasswordController.text)) {
                                return null;
                              } else {
                                return "Passwords Do not match";
                              }
                            }
                          },
                          controller: confirmpasswordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Enter Password Again',
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.all(14),
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            if (value.isEmpty) {}
                          },
                        ),
                      ),
                      Container(
                          height: 70,
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child:
                                Text('Sign Up', style: TextStyle(fontSize: 24)),
                            onPressed: () {
                              formKey.currentState!.save();
                              if (formKey.currentState!.validate()) {
                                api.signup(
                                    User(
                                      Username: UserNameController.text,
                                      Password: passwordController.text,
                                      FirstName: FirstNameController.text,
                                      LastName: LastNameController.text,
                                    ),
                                    context);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Subscription(res)));
                              }
                            },
                          )),
                    ])))));
  }

  bool checkPassword(password, confirmpassword) {
    return password == confirmpassword;
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
