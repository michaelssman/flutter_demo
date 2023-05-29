import 'package:flutter/material.dart';
import 'package:flutter_demo/account/acc_manager.dart';
import 'package:flutter_demo/tools/const.dart';
import 'package:flutter_demo/utils/picker.dart';

import 'index.dart';

class Acc extends StatefulWidget {
  const Acc({Key? key}) : super(key: key);

  @override
  State<Acc> createState() => _AccState();
}

class _AccState extends State<Acc> {
  final TextEditingController _controller = TextEditingController();
  bool _showClear = false;
  void _onChange(String text) {
    setState(() {
      _showClear = text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemBuilder:
              _itemForRow, //itemBuilder是一个回调，方法返回一个widget 相当于cell，鼠标放上去根据提示快速创建createMethod方法
          itemCount: 3, //总共有多少个item
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [NumberKeyboardActionSheet(controller: _controller)],
          ),
        ),
      ],
    );
  }

  //定义方法，返回一个widget
  Widget _itemForRow(BuildContext context, int index) {
    if (index == 0) {
      return _textFieldWidget();
    } else if (index == 2) {
      return SizedBox(
        height: 55,
        child: GestureDetector(
          onTap: () {},
          //整行手势
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                //left
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: const [
                      //图标
                      Image(
                        image: AssetImage('images/badge.png'),
                        width: 20,
                      ),
                      //间隙
                      SizedBox(
                        width: 15,
                      ),
                      //title
                      Text("日期："),
                      SizedBox(
                        width: 5,
                      ),
                      Text("请选择日期"),
                    ],
                  ),
                ),
                //中间
                Expanded(child: Container()),
                //right
                Container(
                  padding: const EdgeInsets.all(10),
                  child: //箭头
                      const Image(
                    image: AssetImage('images/icon_right.png'),
                    width: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () async {
        SqfliteManager sqlManager = SqfliteManager();
        await sqlManager.initDatabase().then((value) => sqlManager.db = value);
        Map<dynamic, dynamic> options = {};
        await sqlManager.selectData().then((value) => options = value);
        HHPicker.showModalSheet(context,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              height: MediaQuery.of(context).size.height / 2.0,
              child: Column(children: [
                SizedBox(
                  height: 50,
                  child: Stack(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Center(
                        child: Text(
                          '选择账户',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ),
                const Divider(height: 1.0),
                Expanded(
                  child: Container(
                    color: themeColor,
                    child: accListView(options),
                  ),
                ),
              ]),
            ));
      },
      //整行手势
      child: Container(
        color: Colors.white,
        height: 55,
        child: Row(
          children: [
            //left
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: const [
                  //图标
                  Image(
                    image: AssetImage('images/badge.png'),
                    width: 20,
                  ),
                  //间隙
                  SizedBox(
                    width: 15,
                  ),
                  //title
                  Text("账户："),
                  SizedBox(
                    width: 5,
                  ),
                  Text("请选择账户"),
                ],
              ),
            ),
            //中间
            Expanded(child: Container()),
            //right
            Container(
              padding: const EdgeInsets.all(10),
              child: //箭头
                  const Image(
                image: AssetImage('images/icon_right.png'),
                width: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFieldWidget() {
    return Container(
      color: Colors.blueGrey,
      height: 50,
      margin: const EdgeInsets.only(left: 5, right: 5, top: 20),
      child: TextField(
        controller: _controller,
        // onChanged: _onChange,
        //自动聚焦
        autofocus: true,
        //光标颜色
        cursorColor: Colors.green,
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        enabled: false,
        keyboardType: TextInputType.none,
        decoration: const InputDecoration(
          //内容约束
          contentPadding: EdgeInsets.only(left: 5),
          border: InputBorder.none, //输入框边框
          hintText: '金额',
          hintStyle: TextStyle(
            color: Color(0xeaeaeaea),
            fontSize: 18,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}
