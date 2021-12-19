import 'package:flutter/material.dart';
import 'package:myapp/app_example/Sign_Up.dart';
import 'package:myapp/models/Login_Model.dart';
import 'package:myapp/models/User_Model.dart';
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

  ButtonState state = ButtonState.init;
  // update the UI depending on below variable values

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width;
    final isInit = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.completed;
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
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                onEnd: () => setState(() {
                                      isAnimating = !isAnimating;
                                    }),
                                width: state == ButtonState.init
                                    ? buttonWidth
                                    : 70,
                                height: 60,
                                // If Button State is Submiting or Completed  show 'buttonCircular' widget as below
                                child: isInit
                                    ? buildButton()
                                    : circularContainer(isDone)),
                          ),
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

  Widget buildButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
        onPressed: () async {
          formKey.currentState!.save();
          if (formKey.currentState!.validate()) {
            setState(() {
              print("Submitting");
              state = ButtonState.submitting;
            });
            Future<UserModel> res = api.login(
                loginmodel(
                    Username: nameController.text,
                    Password: passwordController.text),
                context);
            // res.then((value) => print(value));
            // res.catchError(changeButton());
            res.onError((error, stackTrace) => changeButton());
          } else {
            setState(() {
              state = ButtonState.init;
            });
          }

          // await Future.delayed(Duration(seconds: 2));
          // setState(() {
          //   state = ButtonState.completed;
          // });
          // await Future.delayed(Duration(seconds: 2));
          // setState(() {
          //   state = ButtonState.init;
          // });
        },
        child: const Text('Login', style: TextStyle(fontSize: 20)),
      );

  // this is custom Widget to show rounded container
  // here is state is submitting, we are showing loading indicator on container then.
  // if it completed then showing a Icon.
  changeButton() {
    setState(() {
      state = ButtonState.init;
    });
  }

  Widget circularContainer(bool done) {
    final color = done ? Colors.green : Colors.blue;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: done
            ? const Icon(Icons.done, size: 50, color: Colors.white)
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }

  bool checkPassword(userName, password) {
    return cun == userName && cp == password;
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ButtonStates();
    ;
  }
}

bool isAnimating = true;

//enum to declare 3 state of button
enum ButtonState { init, submitting, completed }

class ButtonStates extends StatefulWidget {
  const ButtonStates({Key? key}) : super(key: key);

  @override
  _ButtonStatesState createState() => _ButtonStatesState();
}

class _ButtonStatesState extends State<ButtonStates> {
  ButtonState state = ButtonState.init;

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width;

    // update the UI depending on below variable values
    final isInit = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.completed;

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(40),
      child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          onEnd: () => setState(() {
                isAnimating = !isAnimating;
              }),
          width: state == ButtonState.init ? buttonWidth : 70,
          height: 60,
          // If Button State is Submiting or Completed  show 'buttonCircular' widget as below
          child: isInit ? buildButton() : circularContainer(isDone)),
    );
  }

  // If Button State is init : show Normal submit button
  Widget buildButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
        onPressed: () async {
          // here when button is pressed
          // we are changing the state
          // therefore depending on state our button UI changed.
          setState(() {
            state = ButtonState.submitting;
          });

          //await 2 sec // you need to implement your server response here.
          await Future.delayed(Duration(seconds: 2));
          setState(() {
            state = ButtonState.completed;
          });
          await Future.delayed(Duration(seconds: 2));
          setState(() {
            state = ButtonState.init;
          });
        },
        child: const Text('Login'),
      );

  // this is custom Widget to show rounded container
  // here is state is submitting, we are showing loading indicator on container then.
  // if it completed then showing a Icon.

  Widget circularContainer(bool done) {
    final color = done ? Colors.green : Colors.blue;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: done
            ? const Icon(Icons.done, size: 50, color: Colors.white)
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }
}
