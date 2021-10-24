import 'package:flutter/material.dart';
import 'package:myapp/models/options.dart';

class oneword extends StatefulWidget {
  oneword({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _onewordState();

  static String getAnswer() {
    return _onewordState.getAnswer();
  }
}

class _onewordState extends State<oneword> {
  late TextEditingController _controller;
  static String answer = '';
  @override
  void initState() {
    _controller = TextEditingController();
    answer = '';
    super.initState();
  }

  @override
  void didUpdateWidget(oneword oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      _controller = TextEditingController();
      answer = '';
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  double _crossAxisSpacing = 8, _mainAxisSpacing = 12, _aspectRatio = 1 / .4;
  int _crossAxisCount = 3;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 2;

    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var height = width / _aspectRatio;
    //_controller.text = "hello";
    return Container(
        // padding: EdgeInsets.all(10),
        height: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: TextFormField(
                showCursor: true,
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Correct Answer';
                  }
                  return null;
                },
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Enter Answer Here',
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
                width: 380,
                // height: 350,
                child: GridView.count(
                  padding: EdgeInsets.all(8.0),
                  crossAxisCount: _crossAxisCount,
                  crossAxisSpacing: _crossAxisSpacing,
                  mainAxisSpacing: _mainAxisSpacing,
                  childAspectRatio: _aspectRatio,
                  shrinkWrap: true,
                  children: [
                    TextButton(
                      onPressed: () {
                        answer = answer + '1';
                        setState(() {
                          _controller.text = answer;
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '1',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          answer = answer + '2';
                          setState(() {
                            _controller.text = answer;
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '2',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                            ),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          answer = answer + '3';
                          setState(() {
                            _controller.text = answer;
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                            ),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          answer = answer + '4';
                          setState(() {
                            _controller.text = answer;
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '4',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                            ),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          answer = answer + '5';
                          setState(() {
                            _controller.text = answer;
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '5',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                            ),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          answer = answer + '6';
                          setState(() {
                            _controller.text = answer;
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '6',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                            ),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          answer = answer + '7';
                          setState(() {
                            _controller.text = answer;
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '7',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                            ),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          answer = answer + '8';
                          setState(() {
                            _controller.text = answer;
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '8',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                            ),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          answer = answer + '9';
                          setState(() {
                            _controller.text = answer;
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '9',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                            ),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          answer = '';
                          setState(() {
                            _controller.text = answer;
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Clear',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                            ),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          answer = answer + '0';
                          setState(() {
                            _controller.text = answer;
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '0',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                            ),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          if ((answer != null) && (answer.length > 0)) {
                            answer = answer.substring(0, answer.length - 1);
                          }
                          setState(() {
                            _controller.text = answer;
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          ),
                        ),
                        child: Center(
                            child: Icon(IconData(0xeeb5,
                                fontFamily: 'MaterialIcons',
                                matchTextDirection: true)))),
                  ],
                ))
          ],
        ));
  }

  static String getAnswer() {
    return answer;
  }
}
