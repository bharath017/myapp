// //import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:myapp/ModifiedPackages/DrawArrow/widget_arrows.dart';

// class lines extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         home: MyHomePagelines(),
//       );
// }

// class MyHomePagelines extends StatefulWidget {
//   MyHomePagelines({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePagelines> {
//   bool showArrows = true;
//   List data1 = ['1', '2', '3', '4'];

//   List data2 = ['One', 'Two', 'Three', 'Four'];
//   @override
//   Widget build(BuildContext context) => ArrowContainer(
//         con: context,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text('Arrows everywhere'),
//           ),
//           body: Container(
//             padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Column(children: [
//                   Wrap(
//                     direction: Axis.vertical,
//                     spacing: 8.0,
//                     runSpacing: 4.0,
//                     //padding: const EdgeInsets.all(8),
//                     children: List.generate(
//                         data2.length,
//                         (index) => ArrowElement(
//                               show: showArrows,
//                               id: 'source' + index.toString(),
//                               targetIds: [targetlist[index]],
//                               sourceAnchor: Alignment.centerRight,
//                               color: Colors.green,
//                               bow: 0.1,
//                               child: Container(
//                                 height: 80,
//                                 width: 80,
//                                 child: TextButton(
//                                     onPressed: () {
//                                       setsource(index);
//                                     },
//                                     style: TextButton.styleFrom(
//                                       primary: Colors.black,
//                                       backgroundColor: Colors.white,
//                                       side: BorderSide(
//                                         color: Colors.grey.shade600,
//                                         width: 1,
//                                       ),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         data1[index],
//                                         style: TextStyle(
//                                           decoration: TextDecoration.none,
//                                           fontSize: 18.0,
//                                         ),
//                                       ),
//                                     )),
//                               ),
//                             )),
//                   )
//                 ]),
//                 Column(children: [
//                   Wrap(
//                     direction: Axis.vertical,
//                     spacing: 8.0,
//                     runSpacing: 4.0,
//                     //padding: const EdgeInsets.all(8),
//                     children: List.generate(
//                         data2.length,
//                         (index) => ArrowElement(
//                               show: true,
//                               id: 'target' + index.toString(),
//                               sourceAnchor: Alignment.centerLeft,
//                               // color: Colors.greenAccent[100],
//                               child: Container(
//                                 height: 80,
//                                 width: 80,
//                                 child: TextButton(
//                                     onPressed: () {
//                                       setTarget(index);
//                                     },
//                                     style: TextButton.styleFrom(
//                                       primary: Colors.black,
//                                       backgroundColor: Colors.white,
//                                       side: BorderSide(
//                                         color: Colors.grey.shade600,
//                                         width: 1,
//                                       ),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         data2[index],
//                                         style: TextStyle(
//                                           decoration: TextDecoration.none,
//                                           fontSize: 18.0,
//                                         ),
//                                       ),
//                                     )),
//                               ),
//                             )),
//                   )
//                 ]),
//               ],
//             ),
//           ),
//         ),
//       );
//   int selectedsource = 0;

//   List<String> targetlist = new List.filled(4, '');
//   void setsource(int index) {
//     selectedsource = index;
//     print(selectedsource);
//   }

//   List mappedArray = [];
//   void setTarget(int index) {
//     var mapped = [selectedsource, index];
//     mappedArray.add(mapped);
//     setState(() {
//       targetlist[selectedsource] = 'target' + index.toString();
//     });

//     print(targetlist);
//   }
// }
