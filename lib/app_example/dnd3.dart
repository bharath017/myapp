import 'package:flutter/material.dart';
import 'package:myapp/boardtest/board_item.dart';
import 'package:myapp/boardtest/board_list.dart';
import 'package:myapp/boardtest/boardview.dart';
import 'package:myapp/boardtest/boardview_controller.dart';

import 'BoardItemObject.dart';
import 'BoardListObject.dart';

class BoardViewExample extends StatelessWidget {
  List<BoardItemObject> listdata = [
    BoardItemObject(title: "item one "),
    BoardItemObject(title: "item two "),
    BoardItemObject(title: "item three "),
  ];
  List<BoardListObject> _listData = [
    BoardListObject(title: "List title 1", items: [
      BoardItemObject(title: "item one "),
      BoardItemObject(title: "item two "),
    ]),
    BoardListObject(title: "List title 2", items: [
      BoardItemObject(title: "item three "),
      BoardItemObject(title: "item four "),
    ]),
    BoardListObject(title: "List title 3", items: [
      BoardItemObject(title: "item five "),
      BoardItemObject(title: "item six "),
    ])
  ];

  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = new BoardViewController();

  @override
  Widget build(BuildContext context) {
    List<BoardList> _lists = [];
    for (int i = 0; i < _listData.length; i++) {
      _lists.add(_createBoardList(_listData[i]) as BoardList);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("board View"),
        ),
        body: Center(
            child: BoardView(
          lists: _lists,
          boardViewController: boardViewController,
        )));
  }

  Widget buildBoardItem(BoardItemObject itemObject) {
    return BoardItem(
        onStartDragItem:
            (int? listIndex, int? itemIndex, BoardItemState? state) {},
        onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
            int? oldItemIndex, BoardItemState? state) {
          //Used to update our local item data
          var item = _listData[oldListIndex!].items![oldItemIndex!];
          _listData[oldListIndex].items!.removeAt(oldItemIndex);
          _listData[listIndex!].items!.insert(itemIndex!, item);
        },
        onTapItem:
            (int? listIndex, int? itemIndex, BoardItemState? state) async {},
        item: Container(
          width: 50,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(itemObject.title!),
          ),
        ));
  }

  Widget _createBoardList(BoardListObject list) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.items!.length; i++) {
      items.insert(i, buildBoardItem(list.items![i]) as BoardItem);
    }

    return BoardList(
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldListIndex) {
        //Update our local list data
        var list = _listData[oldListIndex!];
        _listData.removeAt(oldListIndex);
        _listData.insert(listIndex!, list);
      },
      headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
      backgroundColor: Color.fromARGB(255, 235, 236, 240),
      header: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  list.title!,
                  style: TextStyle(fontSize: 20),
                ))),
      ],
      items: items,
    );
  }
}
