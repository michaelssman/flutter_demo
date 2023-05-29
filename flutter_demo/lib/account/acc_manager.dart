import 'package:flutter/material.dart';
import 'package:flutter_demo/BaseWidget/base_widget.dart';
import 'package:flutter_demo/account/sqflite_manager.dart';
import 'package:flutter_demo/pages/discover/discover_cell.dart';
import 'package:flutter_demo/tools/const.dart';

class AccManager extends StatefulWidget {
  const AccManager({Key? key}) : super(key: key);

  @override
  State<AccManager> createState() => _AccManagerState();
}

class _AccManagerState extends State<AccManager> {
  late Map<dynamic, dynamic> _options = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initDatabase();
  }

  _initDatabase() async {
    SqfliteManager sqlManager = SqfliteManager();
    await sqlManager.initDatabase().then((value) => sqlManager.db = value);
    await sqlManager.selectData().then((value) => _options = value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: themeColor,
        child: MediaQuery.removePadding(
          context: context,
          child: Column(
            children: [
              Container(
                color: Colors.orangeAccent,
                height: 150,
              ),
              Expanded(child: accListView(_options)),
            ],
          ),
          removeTop: true,
        ),
      ), //MyWidget父部件是body。开发界面是放到了body里面。
    );
  }
}

Widget accListView(Map<dynamic, dynamic> pragma) {
  var keys = pragma.keys;
  var a = keys.length;
  var lists = [];
  const titleId = 11111;
  for (var element in keys) {
    lists.add({
      "id": titleId,
      "ac_type": element,
      "ac_name": element,
      "ac_amount": 1080
    });
    lists.addAll(pragma[element]);
  }
  Widget _itemForRow(BuildContext context, int index) {
    if (lists[index]["id"] == 11111) {
      return listViewSection(lists[index]["ac_type"]);
    } else {
      return Column(
        children: [
          DiscoverCell(
            title: lists[index]["ac_name"],
            imageName: defaultImageName,
            onTapCallBack: () {},
          ),
          lineWidget(),
        ],
      );
    }
  }

  return ListView.builder(
    itemBuilder: _itemForRow,
    itemCount: lists.length,
  );
}
