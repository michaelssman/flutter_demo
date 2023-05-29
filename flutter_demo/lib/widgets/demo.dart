import 'package:flutter/material.dart';

import '../tools/const.dart';

class WrapDemo extends StatefulWidget {
  const WrapDemo({Key? key}) : super(key: key);

  @override
  State<WrapDemo> createState() => _WrapDemoState();
}

class _WrapDemoState extends State<WrapDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Scaffold也是一个Widget 里面有appBar
      backgroundColor: Colors.white,
      appBar: AppBar(
        //导航栏 不写就不显示导航栏
        backgroundColor: themeColor, //导航栏背景色
        title: const Text('Scaffold'), //导航栏标题
        centerTitle: true, //安卓 切换应用时显示
        elevation: 0.0, //去除导航栏底部的条
      ),
      body: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        children: const [
          Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('A'),
              ),
              label: Text('张三三')),
          Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('B'),
              ),
              label: Text('李思思')),
          Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('C'),
              ),
              label: Text('王呜呜')),
          Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('D'),
              ),
              label: Text('赵溜溜')),
        ],
      ), //MyWidget父部件是body。开发界面是放到了body里面。
    );
  }
}
