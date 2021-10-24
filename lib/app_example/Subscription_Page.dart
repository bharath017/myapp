import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:myapp/evnironment/Api.dart';
import 'package:myapp/models/ChildModel.dart';
import 'package:myapp/models/SubscriptionModel.dart';
import 'package:myapp/models/User.dart';
import 'package:myapp/services/SignUpService.dart';
import 'package:myapp/models/Age.dart';
import 'package:myapp/models/Child1.dart';
import 'package:myapp/models/Plan.dart';
import 'package:myapp/models/User_Model.dart';
import 'package:myapp/models/user1.dart';

import 'Login_Screen.dart';
import 'Welcome_Page.dart';

const List<String> colors = const <String>[
  'Red',
  'Yellow',
  'Amber',
  'Blue',
  'Black',
  'Pink',
  'Purple',
  'White',
  'Grey',
  'Green',
];

class Subscription extends StatefulWidget {
  final user1 userdata;
  Subscription(this.userdata);

  @override
  State<StatefulWidget> createState() => new _State(userdata);
}

class _State extends State<Subscription> {
  TextEditingController nameController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Child1> ch = [];
  final user1 userdata;
  _State(this.userdata);
  ApiURL api = new ApiURL();
  final SignUpService api1 = SignUpService();
  @override
  void initState() {
    super.initState();
    this.getPlanList();
    this.getAgeList();
    setState(() {
      _CartList(children);
    });
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    String childName = '';
    int AgeId = 0;
    // String _mySelection = data[0]['PlanType'];
    // var cart = context.watch<ChildModel>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Subscription'),
          elevation: 0,
          backgroundColor: Color(0x44000000),
        ),
        body: Container(
            alignment: Alignment.center,
            child: Container(
                width: 400,
                padding: EdgeInsets.all(10),
                child: ListView(children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(10, 40, 10, 30),
                      child: Text(
                        'Subscription Details',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Plan Type',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      )),
                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.black54),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10 - .0)),
                      ),
                    ),
                    child: DropdownButton<dynamic>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black),
                      underline: SizedBox(),
                      hint: Text("Please Select Plan"),
                      onChanged: (dynamic newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          getNoOfChildren(dropdownValue);
                        });
                      },
                      items:
                          data.map<DropdownMenuItem<dynamic>>((dynamic value) {
                        return new DropdownMenuItem<String>(
                          value: value['PlanId'].toString(),
                          child: Text(value['PlanType']),
                        );
                      }).toList(),
                    ),
                  ),
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
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Enter First Name',
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(14),
                      ),
                      obscureText: false,
                      onChanged: (value) {
                        childName = value;
                      },
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Age Group',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      )),
                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.black54),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10 - .0)),
                      ),
                    ),
                    child: DropdownButton<dynamic>(
                      value: dropdownValue1,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black),
                      underline: SizedBox(),
                      hint: Text("Please Select Age Group"),
                      onChanged: (dynamic va) {
                        setState(() {
                          dropdownValue1 = va!;
                        });
                      },
                      items:
                          data1.map<DropdownMenuItem<dynamic>>((dynamic value) {
                        return new DropdownMenuItem<String>(
                          value: value['AgeId'].toString(),
                          child: Text(value['AgeRange']),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(10.0),
                          primary: Colors.black,
                          textStyle: const TextStyle(fontSize: 12),
                          backgroundColor: Color(0xffF29191),
                          elevation: 3),
                      onPressed: () {
                        if (nameController.text == '') {
                          final snackBar = SnackBar(
                            content: const Text('Please Enter Child Name'),
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
                        } else if (noOfChildren <= children.length) {
                          final snackBar = SnackBar(
                            content: Text('Cannot add more than ' +
                                noOfChildren.toString() +
                                ' as per your selected plan'),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {},
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          setState(() {
                            addChild(nameController.text, dropdownValue1);
                          });
                          nameController.text = '';
                        }
                      },
                      child: const Text('Add Child'),
                    ),
                  ),
                  // CupertinoButton(
                  //     child: Text("Select Color :"),
                  //     onPressed: () {
                  //       showModalBottomSheet(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return Container(
                  //               height: 200.0,
                  //               child: CupertinoPicker(
                  //                   itemExtent: 32.0,
                  //                   onSelectedItemChanged: (int index) {
                  //                     setState(() {
                  //                       _selectedIndex = index;
                  //                     });
                  //                   },
                  //                   children: new List<Widget>.generate(
                  //                       colors.length, (int index) {
                  //                     return new Center(
                  //                       child: new Text(colors[index]),
                  //                     );
                  //                   })),
                  //             );
                  //           });
                  //     }),
                  Container(
                      height: 250,
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: _CartList(children)),
                  Container(
                      alignment: Alignment.bottomCenter,
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(10.0),
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 18),
                          backgroundColor: Colors.blue.shade200,
                          elevation: 4,
                        ),
                        child: Text(
                          'Subscribe',
                          //style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          if (dropdownValue == '') {
                            final snackBar = SnackBar(
                              content: const Text('Please Select Plan type'),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (children.isEmpty) {
                            final snackBar = SnackBar(
                              content:
                                  const Text('Please add atleast one child'),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            api1.Subscribe(
                                SubscriptionModel(
                                    PlanId: int.parse(dropdownValue),
                                    UserId: userdata.Id,
                                    Children: children),
                                context);
                          }
                        },
                      )),
                ]))));
  }

  // final String apiUrl = "https://localhost:5001/Subscription/";

  Future<List<AgeGroup>?> getAgeList() async {
    String url = api.geturl + "Subscription/Age";
    final res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      // data = jsonDecode(res.body);
      var resBody = jsonDecode(res.body);
      setState(() {
        data1 = resBody;
        dropdownValue1 = data1[0]['AgeId'].toString();
      });
      return null;
      // return compute(parseAge, res.body);
    } else {
      throw "Failed to load Age list";
    }
  }

  Future<List<Plan>?> getPlanList() async {
    String url = api.geturl + "Subscription/Plans";
    final res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      var resBody = jsonDecode(res.body);
      setState(() {
        data = resBody;

        dropdownValue = data[0]['PlanId'].toString();
      });
      return null;
      // return compute(parsedata, res.body);
    } else {
      throw "Failed to load Plan list";
    }
  }

  String dropdownValue = '';
  String dropdownValue1 = '';
  List data = [];
  List data1 = [];
  List<AgeGroup> agelist = [];
  List<Plan> plans = [];
  List<Plan> parsedata(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    plans = parsed.map<Plan>((json) => Plan.fromJson(json)).toList();
    return plans;
  }

  List<AgeGroup> parseAge(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    agelist = parsed.map<AgeGroup>((json) => AgeGroup.fromJson(json)).toList();
    return agelist;
  }

  int noOfChildren = 0;
  List<Child1> children = [];
  addChild(String childName, String ageId) {
    final msg = new Child1(AgeId: int.parse(ageId), FirstName: childName);

    //var cart = context.read<ChildModel>();
    setState(() {
      children.add(msg);
    });
  }

  removechild(int index) {
    setState(() {
      children.removeAt(index);
    });
  }

  getNoOfChildren(String plan_id) {
    var plan =
        (data.firstWhere((element) => element['PlanId'].toString() == plan_id));
    noOfChildren = plan['NoOfChildren'];
    if (noOfChildren < children.length) {
      setState(() {
        children.removeRange(noOfChildren, children.length);
      });
    }
  }
}

class _CartList extends StatefulWidget {
  final List<Child1> child_data;

  _CartList(this.child_data);

  @override
  _CartState createState() => _CartState(this.child_data);
}

class _CartState extends State<_CartList> {
  _CartState(this._cart);

  List<Child1> _cart;
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;
    // This gets the current state of CartModel and also tells Flutter
    // to rebuild this widget when CartModel notifies listeners (in other words,
    // when it changes).
    return ListView.builder(
        itemCount: _cart.length,
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(_cart[index].FirstName),
                subtitle: Text('Age group : ' + _cart[index].AgeId.toString()),
                trailing: GestureDetector(
                    child: Icon(
                      Icons.remove_circle,
                      color: Colors.red.shade300,
                    ),
                    onTap: () {
                      setState(() {
                        _cart.removeAt(index);
                      });
                    }),
              ),
            ),
          );
        });
  }
}
